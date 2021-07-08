//
//  ATMainViewModel.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Foundation

class ATMainViewModel {
    let apiHandler: APIHandler = APIHandler()

    @Observable var isLoading: Bool = false
    @Observable var errorMessage: String = ""
    @Observable var calendar: CalenderAPI.Calendar?

    func getCalander() {
        isLoading = true
        apiHandler.getCanender { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case let .success(response):
                self.calendar = response
            case let .failure(error):
                self.errorMessage = error.description
            }
        }
    }
}
