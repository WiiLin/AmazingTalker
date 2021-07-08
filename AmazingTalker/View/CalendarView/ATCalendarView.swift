//
//  ATCalendarView.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import UIKit

protocol ATCalendarViewDelegate: AnyObject {
    func getDayTimetable(date: Date) -> [ATTimePeriod]
}

class ATCalendarView: UICollectionView {
    // MARK: - Properties

    private let flowLayout = ATCalendarViewLayout()

    private var weekDate: [Date] = Date.weekDateRange(date: Date()) {
        didSet {
            reloadCalendarView()
        }
    }

    @objc dynamic var canGoLastWeek: Bool = false
    @objc dynamic var canGoNextWeek: Bool = false
    @objc dynamic var weekRangeDescription: String = ""
    weak var calendarViewDelegate: ATCalendarViewDelegate?

    // MARK: - Init

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }

    private func customInit() {
        register(ATCalendarViewCell.self)
        collectionViewLayout = flowLayout
        dataSource = self
    }
}

// MARK: - Interface

extension ATCalendarView {
    func reloadCalendarView() {
        reloadData()
        reloadCanGoLastWeek()
        reloadCanGoNextWeek()
        reloadWeekRangeDescription()
    }

    func goLastWeek() {
        guard canGoLastWeek == true, let last = weekDate.last, let offset = last.addDay(-Date.weekDayCount) else { return }
        weekDate = Date.weekDateRange(date: offset)
    }

    func goNextWeek() {
        guard canGoNextWeek == true, let last = weekDate.last, let offset = last.addDay(Date.weekDayCount) else { return }
        weekDate = Date.weekDateRange(date: offset)
    }
}

// MARK: - Private

private extension ATCalendarView {
    func reloadCanGoLastWeek() {
        guard let first = weekDate.first else {
            return
        }
        if let lastWeekDay = first.addDay(-Date.weekDayCount), let lastWeekDayLast = Date.weekDateRange(date: lastWeekDay).last, lastWeekDayLast.isPastDays {
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
}

// MARK: - UICollectionViewDataSource

extension ATCalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDate.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ATCalendarViewCell
        let date = weekDate[indexPath.row]

        cell.configureDate(weekDate[indexPath.row])

        if date.isPastDays {
            cell.configureDayTimetable(calendarViewDelegate?.getDayTimetable(date: weekDate[indexPath.row]) ?? [])
        }
        return cell
    }
}
