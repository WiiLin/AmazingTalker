//
//  MainViewModel.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func didChangeWeek()
    func didFinishedLoadTimetable()
}

class MainViewModel {
    // MARK: - Properties

    private let apiRequestable: APIRequestable
    weak var delegate: MainViewModelDelegate?

    @Observable private(set) var week: Week
    @Observable private(set) var errorMessage: String = ""
    @Observable private(set) var canGoLastWeek: Bool = false
    @Observable private(set) var canGoNextWeek: Bool = false
    @Observable private(set) var weekRangeDescription: String = ""

    // MARK: - Life Cycle

    init(apiRequestable: APIRequestable, beginDate: Date) {
        self.apiRequestable = apiRequestable
        week = Week(date: beginDate)
        $week(bind: self, fireNow: true) { weakSelf, weekDate in
            weakSelf.updateComponents()
        }
    }
}

// MARK: - Private Method

private extension MainViewModel {
    func reloadCanGoLastWeek() {
        if let lastWeekDay = week.first.addDay(-Date.weekDayCount), let lastWeekDayLast = Date.weekDate(of: lastWeekDay).last, lastWeekDayLast.moreThanOrEqualTo(Date()) {
            canGoLastWeek = true
        } else {
            canGoLastWeek = false
        }
    }

    func reloadCanGoNextWeek() {
        canGoNextWeek = true
    }

    func updateComponents() {
        reloadCanGoLastWeek()
        reloadCanGoNextWeek()
        weekRangeDescription = week.rangeDescription
        delegate?.didChangeWeek()
    }
}

// MARK: - Interface

extension MainViewModel {
    func goLastWeek() {
        week.goLastWeek()
        updateComponents()
    }

    func goNextWeek() {
        week.goNextWeek()
        updateComponents()
    }

    func getCalander() {
        apiRequestable.getTimetable { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(timetable):
                PeriodHandler.shared.configure(timetable: timetable)
                self.delegate?.didFinishedLoadTimetable()
            case let .failure(error):
                self.errorMessage = error.description
            }
        }
    }
}
