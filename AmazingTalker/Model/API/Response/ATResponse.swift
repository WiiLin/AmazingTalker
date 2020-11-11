//
//  ATResponse.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Foundation

struct ATResponse {
    struct Empty: Decodable {}

    struct Calendar: Decodable {
        let available: [ATTimePeriod.Range]
        let booked: [ATTimePeriod.Range]
    }
}
