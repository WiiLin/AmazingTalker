//
//  ATApi.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Alamofire
import Foundation

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
