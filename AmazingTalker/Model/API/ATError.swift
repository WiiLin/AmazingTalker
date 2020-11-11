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
    case serverError(String, Int)

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
        case let .serverError(message, _):
            return message
        }
    }

    static func serverError(errorObject: [String: Any]) -> ATError {
        if let code = errorObject["statusCode"] as? Int,
            let message = errorObject["message"] as? String {
            let displayMessage: String = {
                if let errorCode = errorObject["errorCode"] as? String {
                    return errorCode.localized
                } else {
                    return message
                }
            }()
            return .serverError("[\(code)] \(displayMessage)", code)
        }
        return .serverErrorParseFailedError
    }

    static func nsError(error: NSError) -> ATError {
        return .custom(error.localizedDescription)
    }

    var code: Int {
        switch self {
        case let .serverError(_, code):
            return code
        default:
            return 0
        }
    }
}

extension NSError {
    public var isCancel: Bool {
        if NSURLErrorCancelled == code {
            return true
        } else {
            return false
        }
    }

    public var isInternetError: Bool {
        if NSURLErrorNotConnectedToInternet == code ||
            NSURLErrorTimedOut == code {
            return true
        } else {
            return false
        }
    }
}
