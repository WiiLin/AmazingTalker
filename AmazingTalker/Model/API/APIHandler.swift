//
//  ATAPIManager.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Alamofire
import Foundation

protocol APIRequestable {
    func getCanender(completionHandler: @escaping (Result<CalenderRequest.Calendar, APIError>) -> Void)
}

class APIHandler: APIRequestable {
    private lazy var requestHandler: APIRequestHandler = APIRequestHandler()

    func getCanender(completionHandler: @escaping (Result<CalenderRequest.Calendar, APIError>) -> Void) {
        let request = CalenderRequest()
        requestHandler.request(request, responseType: CalenderRequest.Calendar.self, completionHandler: completionHandler)
    }
}

class FakeAPIHandler: APIRequestable {
    private lazy var parseHandler = APIParseHandler()

    func getCanender(completionHandler: @escaping (Result<CalenderRequest.Calendar, APIError>) -> Void) {
        let request = CalenderRequest()
        parseHandler.parse(request.path.testData, responseType: CalenderRequest.Calendar.self, completionHandler: completionHandler)
    }
}
