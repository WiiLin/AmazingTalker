//
//  FakeAPIHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

class FakeAPIHandler: APIRequestable {
    private lazy var parseHandler = APIParseHandler()

    func getCanender(completionHandler: @escaping (Result<CalenderRequest.Calendar, APIError>) -> Void) {
        let request = CalenderRequest()
        parseHandler.parse(request.path.testData, responseType: CalenderRequest.Calendar.self, completionHandler: completionHandler)
    }
}
