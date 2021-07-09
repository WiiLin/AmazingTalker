//
//  APIRequestHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Alamofire
import Foundation

class APIRequestHandler {
    private lazy var parseHandler = APIParseHandler()
    private let sessionManager: Session = {
        let session = Session.default
        session.session.configuration.timeoutIntervalForRequest = 60
        return session
    }()

    func request<ApiRequest: Requestable, ApiResponse: Decodable>(_ apiRequest: ApiRequest,
                                                                  responseType: ApiResponse.Type,
                                                                  completionHandler: @escaping (Result<ApiResponse, APIError>) -> Void) {
        guard let url = URL.apiURL(path: apiRequest.path) else {
            completionHandler(.failure(.urlCreateError))
            return
        }

        let request: DataRequest = sessionManager.request(url,
                                                          method: apiRequest.method,
                                                          parameters: apiRequest.parameters,
                                                          encoding: URLEncoding.default,
                                                          headers: apiRequest.headers)

        self.request(request: request, method: apiRequest.method, parameters: apiRequest.parameters) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.parseHandler.parse(data, responseType: responseType, completionHandler: completionHandler)
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }

    func request(request: DataRequest, method: HTTPMethod, parameters: Parameters?, completionHandler: @escaping (Result<Data?, APIError>) -> Void) {
        request
            .validate(statusCode: 200 ..< 400)
            .response { response in
                switch response.result {
                case let .success(response):
                    completionHandler(.success(response))
                case let .failure(error):
                    let nsError = error as NSError
                    completionHandler(.failure(.custom(nsError.localizedDescription)))
                }
            }
    }
}
