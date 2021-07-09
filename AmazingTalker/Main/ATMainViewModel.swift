//
//  ATMainViewModel.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/8.
//

import Foundation

protocol ATMainViewModelDelegate: AnyObject {
    func reloadCalendarView()
}

class ATMainViewModel {
    
    //MARK: - Properties
    private let apiRequestable: APIRequestable
    
    weak var delegate: ATMainViewModelDelegate?
    @Observable var weekDate: [Date] = Date.weekDate(of: Date())
    @Observable var isLoading: Bool = false
    @Observable var errorMessage: String = ""
    @Observable var calendar: CalenderRequest.Calendar?
    
    @Observable var canGoLastWeek: Bool = false
    @Observable var canGoNextWeek: Bool = false
    @Observable var weekRangeDescription: String = ""
    
    
    //MARK: - Life Cycle
    init(apiRequestable: APIRequestable,date: Date) {
        self.apiRequestable = apiRequestable

        $weekDate(bind: self,fireNow: true)  { weakSelf, weekDate in
            weakSelf.reloadCalendarView()
        }
    }
    
    func reloadCanGoLastWeek() {
        guard let first = weekDate.first else {
            return
        }
        if let lastWeekDay = first.addDay(-Date.weekDayCount), let lastWeekDayLast = Date.weekDate(of: lastWeekDay).last, lastWeekDayLast.isPastDays {
            canGoLastWeek = true
        } else {
            canGoLastWeek = false
        }
    }

    func reloadCanGoNextWeek() {
        canGoNextWeek = true
    }

    func reloadWeekRangeDescription() {
        guard weekDate.count == Date.weekDayCount, let first = weekDate.first, let last = weekDate.last else { return }
        let rangeDescriptionFormat = "%d/%02d/%02d - %d"
        let rangeDescription = String(format: rangeDescriptionFormat, first.year, first.month, first.day, last.day)
        weekRangeDescription = rangeDescription
    }
    
    func reloadCalendarView() {
        reloadCanGoLastWeek()
        reloadCanGoNextWeek()
        reloadWeekRangeDescription()
        delegate?.reloadCalendarView()
    }
   
}

//MARK: - Interface
extension  ATMainViewModel {
    func goLastWeek() {
        guard canGoLastWeek == true, let last = weekDate.last, let offset = last.addDay(-Date.weekDayCount) else { return }
        weekDate = Date.weekDate(of: offset)
    }
    
    func goNextWeek() {
        guard canGoNextWeek == true, let last = weekDate.last, let offset = last.addDay(Date.weekDayCount) else { return }
        weekDate = Date.weekDate(of: offset)
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
