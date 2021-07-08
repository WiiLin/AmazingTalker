//
//  ATApi.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Alamofire

protocol Api {
    associatedtype ApiResponse: Decodable

    var request: Encodable? { get }
    var path: APIHandler.Path { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var testMode: Bool { get }
}

extension Api where Self: Encodable {
    var parameters: Parameters? {
        if let requestType = request, let parameters = requestType.parameters(keyEncodingStrategy: .convertToSnakeCase), !parameters.isEmpty {
            return parameters
        } else {
            return nil
        }
    }
}

struct CalenderApi: Api, Encodable {
    struct Calendar: Decodable {
        let available: [ATTimePeriod.Range]
        let booked: [ATTimePeriod.Range]
    }

    typealias ApiResponse = Calendar
    var request: Encodable? { return self }
    var path: APIHandler.Path { return .calendar }
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
    let testMode: Bool
}
