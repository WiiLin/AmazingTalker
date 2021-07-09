//
//  ATApi.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Alamofire
import Foundation

struct Timetable: Decodable {
    struct Range: Decodable {
        let start: Date
        let end: Date
    }

    let available: [Range]
    let booked: [Range]
}

struct TimetableRequest: Requestable, Encodable {
    typealias ApiResponse = Timetable
    var request: Encodable? { return self }
    var path: APIPath { return .timetable }
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
}
