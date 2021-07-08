//
//  ATAPIManager.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Alamofire
import Foundation

class APIHandler {

    private lazy var requestHandler: APIRequestHandler = APIRequestHandler()

    func getCanender(completionHandler: @escaping (Result<CalenderAPI.Calendar, APIError>) -> Void) {
        let api = CalenderAPI(testMode: true)
        requestHandler.request(api: api, responseType: CalenderAPI.Calendar.self, completionHandler: completionHandler)
    }
}
