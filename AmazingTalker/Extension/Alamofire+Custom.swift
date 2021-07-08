//
//  Alamofire+Custom.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//
import Alamofire
import Foundation

extension Encodable {
    var parameters: Parameters? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? jsonEncoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? Parameters }
    }
}
