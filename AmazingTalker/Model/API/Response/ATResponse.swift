//
//  ATResponse.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Foundation

struct ATResponse {
    struct Empty: Decodable { }
    
    struct Calendar: Decodable {
        struct Range: Decodable {
            let start: Date
            let end: Date
        }
        let available: [Range]
        let booked: [Range]
    }

}
