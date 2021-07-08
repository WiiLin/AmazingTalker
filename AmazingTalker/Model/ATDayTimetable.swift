//
//  ATDayTimetable.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/11.
//

import UIKit

struct ATTimePeriod {
    struct Range: Decodable {
        let start: Date
        let end: Date
    }

    enum Period {
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

    let range: Range
    let period: Period

    static func dayTimetable(calendar: CalenderAPI.Calendar?, date: Date) -> [ATTimePeriod] {
        guard let calendar = calendar else { return [] }
        let available = calendar.available.filter { $0.start.inSameDayAs(date) }.map { ATTimePeriod(range: $0, period: .available) }
        let booked = calendar.booked.filter { $0.start.inSameDayAs(date) }.map { ATTimePeriod(range: $0, period: .booked) }
        var dayTimetable = available + booked
        dayTimetable.sort { (lhs, rhs) -> Bool in
            lhs.range.start < rhs.range.start
        }
        return dayTimetable
    }
}
