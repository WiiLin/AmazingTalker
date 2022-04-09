//
//  URL+Custom.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

extension URL {
    static let apiHost: URL = URL(string: "https://api.amazingtalker.com")!

    static func apiURL(path: APIPath) -> URL? {
        if var urlComponents: URLComponents = URLComponents(url: apiHost, resolvingAgainstBaseURL: true) {
            urlComponents.path = path.path
            return urlComponents.url
        } else {
            return nil
        }
    }
}
