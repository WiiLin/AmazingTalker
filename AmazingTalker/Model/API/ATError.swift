//
//  ATError.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Foundation

enum ATError: Error, Equatable {
    case apiResponseError
    case apiResponseSourceError
    case urlCreateError
    case serverErrorParseFailedError
    case custom(String)

    var description: String {
        switch self {
        case .apiResponseError:
            return "API response error"
        case .apiResponseSourceError:
            return "API response source error"
        case .urlCreateError:
            return "Could not create URL from components"
        case .serverErrorParseFailedError:
            return "Could not parse server error"
        case let .custom(message):
            return message
        }
    }
}
