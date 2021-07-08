//
//  ATMainViewController.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import UIKit

class ATMainViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var lastWeekButton: UIButton!
    @IBOutlet var nextWeekButton: UIButton!
    @IBOutlet var weekRangeLabel: UILabel!
    @IBOutlet var timeZoneLabel: UILabel! {
        didSet {
            var timeZone = TimeZone.current.identifier
            if let abbreviation = TimeZone.current.abbreviation() {
                timeZone += "(\(abbreviation))"
            }
            timeZoneLabel.text = String(format: "time_display_in".localized, timeZone)
        }
    }

    @IBOutlet var calendarView: ATCalendarView!
    var canGoNextWeekkObservation: NSKeyValueObservation?
    var canGoLastWeekObservation: NSKeyValueObservation?
    var weekRangeDescriptionObservation: NSKeyValueObservation?
    var calendar: CalenderApi.Calendar?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
//        ATAPIManager.shared.getCalendar { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(calendar):
//                self.calendar = calendar
//                self.calendarView.reloadCalendarView()
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
    }

    deinit {
        canGoNextWeekkObservation?.invalidate()
        canGoLastWeekObservation?.invalidate()
        weekRangeDescriptionObservation?.invalidate()
    }
}

// MARK: - Privaite method

private extension ATMainViewController {
    func setupCalendarView() {
        calendarView.calendarViewDelegate = self
        canGoNextWeekkObservation = calendarView.observe(\.canGoNextWeek, options: [.new]) { [weak self] calendarView, canGoNextWeek in
            guard let self = self else { return }
            self.nextWeekButton.isEnabled = canGoNextWeek.newValue ?? false
        }

        canGoLastWeekObservation = calendarView.observe(\.canGoLastWeek, options: [.new]) { [weak self] calendarView, canGoLastWeek in
            guard let self = self else { return }
            self.lastWeekButton.isEnabled = canGoLastWeek.newValue ?? false
        }

        weekRangeDescriptionObservation = calendarView.observe(\.weekRangeDescription, options: [.new]) { [weak self] calendarView, weekRangeDescription in
            guard let self = self else { return }
            self.weekRangeLabel.text = weekRangeDescription.newValue
        }
    }

    @IBAction func onClickLastWeek(_ sender: Any) {
        calendarView.goLastWeek()
    }

    @IBAction func onClickNextWeek(_ sender: Any) {
        calendarView.goNextWeek()
    }
}

extension ATMainViewController: ATCalendarViewDelegate {
    func getDayTimetable(date: Date) -> [ATTimePeriod] {
        return ATTimePeriod.dayTimetable(calendar: calendar, date: date)
    }
}
