//
//  ATAPIManager.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

class APIHandler: APIRequestable {
    private lazy var requestHandler: APIRequestHandler = APIRequestHandler()

    func getCanender(completionHandler: @escaping (Result<CalenderRequest.Calendar, APIError>) -> Void) {
        let request = CalenderRequest()
        requestHandler.request(request, responseType: CalenderRequest.Calendar.self, completionHandler: completionHandler)
    }
}
