//
//  Requestable.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
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
