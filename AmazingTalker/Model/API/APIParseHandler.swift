//
//  APIParseHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

class APIParseHandler {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        decoder.dateDecodingStrategy = .custom { decoder -> Date in
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

    func parse<ApiResponse: Decodable>(_ data: Data?,
                                       responseType: ApiResponse.Type,
                                       completionHandler: @escaping (Result<ApiResponse, APIError>) -> Void)
    {
        if let data = data {
            do {
                let response = try jsonDecoder.decode(responseType, from: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(.custom((error as NSError).localizedDescription)))
            }
        } else {
            completionHandler(.failure(.apiResponseSourceError))
        }
    }
}
