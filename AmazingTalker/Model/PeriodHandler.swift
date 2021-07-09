//
//  TimePeriodHandler.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
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

    func period(with date: Date) -> [Period] {
        let available = available.filter { $0.start.inSameDayAs(date) }.map { Period(range: $0, period: .available) }
        let booked = booked.filter { $0.start.inSameDayAs(date) }.map { Period(range: $0, period: .booked) }
        var dayTimetable = available + booked
        dayTimetable.sort { (lhs, rhs) -> Bool in
            lhs.range.start < rhs.range.start
        }
        return dayTimetable
    }
}
