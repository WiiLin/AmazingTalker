//
//  FakeAPIHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

class FakeAPIHandler: APIRequestable {
    private lazy var parseHandler = APIParseHandler()

    func getTimetable(completionHandler: @escaping (Result<Timetable, APIError>) -> Void) {
        let request = TimetableRequest()
        parseHandler.parse(request.path.testData, responseType: Timetable.self, completionHandler: completionHandler)
    }
}
