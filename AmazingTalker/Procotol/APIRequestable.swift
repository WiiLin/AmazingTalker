//
//  APIRequestable.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

protocol APIRequestable {
    func getTimetable(completionHandler: @escaping (Result<Timetable, APIError>) -> Void)
}
