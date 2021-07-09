//
//  APIRequestable.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

protocol APIRequestable {
    func getCanender(completionHandler: @escaping (Result<CalenderRequest.Calendar, APIError>) -> Void)
}
