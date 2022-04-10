//
//  APIRequestHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

class APIRequestHandler {
    private lazy var parseHandler = APIParseHandler()
    func request<ApiRequest: Requestable, ApiResponse: Decodable>(_ apiRequest: ApiRequest,
                                                                  responseType: ApiResponse.Type,
                                                                  completionHandler: @escaping (Result<ApiResponse, APIError>) -> Void)
    {
        guard let url = URL.apiURL(path: apiRequest.path) else {
            completionHandler(.failure(.urlCreateError))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.parseHandler.parse(data, responseType: responseType, completionHandler: completionHandler)
        }.resume()
    }
}
