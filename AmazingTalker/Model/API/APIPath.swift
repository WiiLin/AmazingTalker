//
//  APIPath.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

enum APIPath: String {
    case calendar
    var path: String {
        return rawValue
    }

    var testData: Data? {
        guard let path = Bundle.main.path(forResource: path, ofType: "json") else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
