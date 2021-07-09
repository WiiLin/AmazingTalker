//
//  ATAPIManager.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

class APIHandler: APIRequestable {
    private lazy var requestHandler: APIRequestHandler = APIRequestHandler()

    func getTimetable(completionHandler: @escaping (Result<Timetable, APIError>) -> Void) {
        let request = BookingStatusRequest()
        requestHandler.request(request, responseType: Timetable.self, completionHandler: completionHandler)
    }
}
