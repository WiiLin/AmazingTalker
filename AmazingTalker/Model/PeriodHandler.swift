//
//  TimePeriodHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import UIKit

struct Period {
    enum Status {
        case available
        case booked

        var color: UIColor? {
            switch self {
            case .available:
                return .enableGreen
            case .booked:
                return .disableGray
            }
        }
    }

    let range: Timetable.Range
    let period: Status
}

class PeriodHandler {
    static let shared = PeriodHandler()
    var available: [Timetable.Range] = []
    var booked: [Timetable.Range] = []

    func configure(timetable: Timetable) {
        available = timetable.available
        booked = timetable.booked
    }
    
    private var periodsCache: [Date: [Period]] = [:]

    func periods(with date: Date) -> [Period] {
        guard date.moreThanOrEqualTo(Date()) else { return [] }
        if let periods = periodsCache[date] {
            return periods
        } else {
            let available = available.filter { $0.start.inSameDayAs(date) }.map { Period(range: $0, period: .available) }
            let booked = booked.filter { $0.start.inSameDayAs(date) }.map { Period(range: $0, period: .booked) }
            var periods = available + booked
            periods.sort { (lhs, rhs) -> Bool in
                lhs.range.start < rhs.range.start
            }
            periodsCache[date] = periods
            return periods
        }
    }
}
