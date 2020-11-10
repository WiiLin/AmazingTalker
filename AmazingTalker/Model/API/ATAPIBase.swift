//
//  ATAPIBase.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Foundation
import Alamofire

enum ATAPIURLComponents: String {
    case host = "amazingtalker.com"
    case scheme = "https"
    case port = "8080"
    case basePath = "/api/"
}

enum ATAPIPath: String, Equatable {
    case calendar
    
    var path: String {
        return ATAPIURLComponents.basePath.rawValue + rawValue
    }
    
    var testCaseJsonData: Data? {
        let fileName: String = {
            switch self {
            case .calendar:
                return "calendar"
            }
        }()
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}



class ATAPIBase: NSObject  {

    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = dateFormatter.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "")
            }
        }
        return decoder
    }()

    private var baseURLComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = ATAPIURLComponents.scheme.rawValue
        urlComponents.host = ATAPIURLComponents.host.rawValue
        urlComponents.port = Int(ATAPIURLComponents.port.rawValue)
        return urlComponents
    }()

    private let sessionManager: Session = {
        let session = Session.default
        session.session.configuration.timeoutIntervalForRequest = 60
        return session
    }()
    
    let testMode: Bool = true

    // MARK: - Interface

    func request<ApiRequest: Encodable, ApiResponse: Decodable>(path: ATAPIPath,
                                                                method: HTTPMethod,
                                                                headers: HTTPHeaders? = nil,
                                                                needLogin: Bool = false,
                                                                requestType: ApiRequest?,
                                                                responseType: ApiResponse.Type,
                                                                completionHandler: @escaping (Result<ApiResponse, ATError>) -> Void) {
        
        func parseResponseData<ApiResponse: Decodable>(_ data: Data?,
                               responseType: ApiResponse.Type,
                               completionHandler: @escaping (Result<ApiResponse, ATError>) -> Void) {
            if let data = data {
                do {
                    let response = try self.jsonDecoder.decode(responseType, from: data)
                    completionHandler(.success(response))
                } catch {
                    print("JSONDecoder Error\(error)")
                    completionHandler(.failure(.custom((error as NSError).localizedDescription)))
                }
            } else if responseType is ATResponse.Empty.Type {
                completionHandler(.success(ATResponse.Empty() as! ApiResponse))
            } else {
                completionHandler(.failure(.apiResponseSourceError))
            }
            
        }
        guard testMode == false else {
            parseResponseData(path.testCaseJsonData, responseType: responseType, completionHandler: completionHandler)
            return
        }
        
        
        
        baseURLComponents.path = path.path
        guard let url = baseURLComponents.url else {
            completionHandler(.failure(.urlCreateError))
            return
        }

        let parameters: Parameters? = {
            if let parameters = requestType?.parameters, !parameters.isEmpty {
                return parameters
            } else {
                return nil
            }
        }()
        let request: DataRequest = sessionManager.request(url,
                                                          method: method,
                                                          parameters: parameters,
                                                          encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                                                          headers: headers,
                                                          interceptor: self)
        self.request(request: request, method: method, parameters: parameters) {[weak self] result in
            switch result {
            case let .success(data):
                parseResponseData(data, responseType: responseType, completionHandler: completionHandler)
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}

// MARK: - Private Method

private extension ATAPIBase {
    
    func apiURL(path: ATAPIPath) -> URL? {
        baseURLComponents.path = path.path
        if let url = baseURLComponents.url {
            return url
        } else {
            fatalError()
        }
    }

    func request(request: DataRequest, method: HTTPMethod, parameters: Parameters?, completionHandler: @escaping (Result<Data?, ATError>) -> Void) {
        request
            .validate(statusCode: 200 ..< 400)
            .response { response in
                self.printResponse(response: response, parameters: parameters, method: method)
                switch response.result {
                case let .success(response):
                    completionHandler(.success(response))
                case let .failure(responseError):
                    let responseError = responseError as NSError
                    print("\(responseError.localizedDescription)")
                    if let data = response.data {
                        if let jsonDictionary = data.jsonDataDictionary {
                            completionHandler(.failure(ATError.serverError(errorObject: jsonDictionary)))
                        } else {
                            completionHandler(.failure(ATError.nsError(error: responseError)))
                        }
                    } else {
                        completionHandler(.failure(ATError.nsError(error: responseError)))
                    }
                }
            }
    }
}

// MARK: - RequestInterceptor

extension ATAPIBase: RequestInterceptor {
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

private extension ATAPIBase {
    func printResponse(response: AFDataResponse<Data?>, parameters: Parameters?, method: HTTPMethod) {
        print("🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻")
        print("✈️ \(response.request?.url?.absoluteString ?? "")")
        print("⚙️ \(method.rawValue)")
        let allHTTPHeaderFields = response.request?.allHTTPHeaderFields ?? [:]
        print("📇 \(allHTTPHeaderFields)")

        let parameters = parameters ?? [:]
        print("🎒 \(parameters)")

        let statusCode = response.response?.statusCode ?? -1
        print("🚥 \(statusCode)")

        if let data = response.data {
            print("🎁 \(String(decoding: data, as: UTF8.self))")
        }
        print("🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻🤟🏻")
    }
}


extension Encodable {
    var parameters: Parameters? {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? Parameters }
    }
}


extension Data {
    var jsonDataDictionary: [String: Any]? {
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves) as? [String: Any] {
                return dictionary
            } else {
                return nil
            }
        } catch {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
}
