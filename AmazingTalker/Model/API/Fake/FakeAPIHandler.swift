//
//  FakeAPIHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

class FakeAPIHandler: APIRequestable {
    private lazy var parseHandler = APIParseHandler()

    func getTimetable(completionHandler: @escaping (Result<Timetable, APIError>) -> Void) {
        let request = TimetableRequest()
        parseHandler.parse(request.path.testData, responseType: Timetable.self, completionHandler: completionHandler)
    }
}
