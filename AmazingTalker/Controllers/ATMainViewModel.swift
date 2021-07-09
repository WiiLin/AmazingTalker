//
//  ATMainViewModel.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Foundation

class ATMainViewModel {
    let apiRequestable: APIRequestable

    @Observable var isLoading: Bool = false
    @Observable var errorMessage: String = ""
    @Observable var calendar: CalenderRequest.Calendar?

    init(apiRequestable: APIRequestable) {
        self.apiRequestable = apiRequestable
    }
    
    
    func getCalander() {
        isLoading = true
        apiRequestable.getCanender { [weak self] result in
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
