//
//  TimeZone+Custom.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

extension TimeZone {
    var description: String {
        var description: String = identifier
        if let abbreviation = abbreviation() {
            description += "(\(abbreviation))"
        }
        return description
    }
}
