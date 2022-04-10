//
//  ATAPIManager.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

class APIHandler: APIRequestable {
    private lazy var requestHandler: APIRequestHandler = .init()

    func getTimetable(completionHandler: @escaping (Result<Timetable, APIError>) -> Void) {
        let request = TimetableRequest()
        requestHandler.request(request, responseType: Timetable.self, completionHandler: completionHandler)
    }
}
