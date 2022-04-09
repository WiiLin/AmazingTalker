//
//  TimeZone+Custom.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
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
