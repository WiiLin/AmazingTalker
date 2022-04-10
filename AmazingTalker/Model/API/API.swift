//
//  Api.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

struct ApiEmptyResponse: Decodable {}

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
    var method: HTTPMethod { return .GET }
}
