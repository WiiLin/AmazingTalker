//
//  URL+Custom.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Foundation

extension URL {
    static let apiHost: URL = URL(string: "https://api.amazingtalker.com")!

    static func apiUrl(path: APIHandler.Path) -> URL? {
        var urlComponents: URLComponents = URLComponents(url: apiHost, resolvingAgainstBaseURL: true)!
        urlComponents.path = path.rawValue
        return urlComponents.url
    }
}
