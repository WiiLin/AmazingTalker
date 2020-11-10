//
//  ATAPIManager.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import Foundation


class ATAPIManager: ATAPIBase {
    static let shared: ATAPIManager = ATAPIManager()
    
    func getCalendar(completionHandler: @escaping (Result<ATResponse.Calendar, ATError>) -> Void) {
        request(path: .calendar, method: .get, requestType: ATRequest.Empty(), responseType: ATResponse.Calendar.self, completionHandler: completionHandler)
    }
}
