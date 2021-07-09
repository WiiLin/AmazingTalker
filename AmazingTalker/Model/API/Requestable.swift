//
//  ATApi.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Alamofire
import Foundation

protocol Requestable {
    associatedtype ApiResponse: Decodable

    var request: Encodable? { get }
    var path: APIPath { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}

extension Requestable where Self: Encodable {
    var parameters: Parameters? {
        if let requestType = request, let parameters = requestType.parameters(keyEncodingStrategy: .convertToSnakeCase), !parameters.isEmpty {
            return parameters
        } else {
            return nil
        }
    }
}

enum APIPath: String {
    case calendar
    var path: String {
        return rawValue
    }

    var testData: Data? {
        guard let path = Bundle.main.path(forResource: path, ofType: "json") else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}

struct CalenderRequest: Requestable, Encodable {
    struct Calendar: Decodable {
        let available: [ATTimePeriod.Range]
        let booked: [ATTimePeriod.Range]
    }

    typealias ApiResponse = Calendar
    var request: Encodable? { return self }
    var path: APIPath { return .calendar }
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
}
