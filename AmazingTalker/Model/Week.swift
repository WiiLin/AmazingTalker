//
//  WeekDate.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import Foundation

class Week {
    var dates: [Date]
    var first: Date! {
        return dates.first!
    }

    var last: Date! {
        return dates.last!
    }

    var rangeDescription: String {
        let rangeDescription = String(format: "%d/%02d/%02d - %d", first.year, first.month, first.day, last.day)
        return rangeDescription
    }

    init(date: Date) {
        dates = Date.weekDate(of: date)
    }

    func goLastWeek() {
        guard let offset = last.addDay(-Date.weekDayCount) else { return }
        dates = Date.weekDate(of: offset)
    }

    func goNextWeek() {
        guard let offset = last.addDay(Date.weekDayCount) else { return }
        dates = Date.weekDate(of: offset)
    }
}
