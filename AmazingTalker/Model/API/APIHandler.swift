//
//  ATAPIManager.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Alamofire
import Foundation

class APIHandler {
    enum Path: String {
        case calendar
        var path: String {
            return rawValue
        }

        var testData: Data? {
            guard let path = Bundle.main.path(forResource: path, ofType: "json") else { return nil }
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
    }

    private lazy var requestHandler: APIRequestHandler = APIRequestHandler()

    func getCanender(completionHandler: @escaping (Result<CalenderApi.Calendar, ATError>) -> Void) {
        let api = CalenderApi(testMode: true)
        requestHandler.request(api: api, responseType: CalenderApi.Calendar.self, completionHandler: completionHandler)
    }
}
