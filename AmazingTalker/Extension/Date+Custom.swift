//
//  Date+Custom.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import Foundation

extension Date {
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }

    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }

    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }

    var weekday: Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: self)
    }

    var shortWeekdaySymbol: String {
        return Calendar.current.shortWeekdaySymbols[weekday - 1]
    }

    func inSameDayAs(_ date: Date) -> Bool {
        return NSCalendar.current.isDate(self, inSameDayAs: date)
    }

    func addDay(_ day: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: day, to: self)
    }

    func string(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    func moreThanOrEqualTo(_ date: Date) -> Bool {
        if inSameDayAs(date) {
            return true
        } else {
            return self > date
        }
    }

    static func weekDate(of date: Date) -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: date)
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
        return days
    }

    static var weekDayCount: Int {
        return Calendar.current.shortWeekdaySymbols.count
    }
}
