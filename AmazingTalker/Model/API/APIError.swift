//
//  ATError.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Foundation

enum APIError: Error, Equatable {
    case apiResponseSourceError
    case urlCreateError
    case custom(String)

    var description: String {
        switch self {
        case .apiResponseSourceError:
            return "API response source error"
        case .urlCreateError:
            return "Could not create URL from components"
        case let .custom(message):
            return message
        }
    }
}
