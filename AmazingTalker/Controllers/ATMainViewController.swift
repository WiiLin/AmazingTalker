//
//  ATMainViewController.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//
import PKHUD
import UIKit

class ATMainViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var lastWeekButton: UIButton!
    @IBOutlet var nextWeekButton: UIButton!
    @IBOutlet var weekRangeLabel: UILabel!
    @IBOutlet var timeZoneLabel: UILabel!

    @IBOutlet var calendarView: ATCalendarView!
    var canGoNextWeekkObservation: NSKeyValueObservation?
    var canGoLastWeekObservation: NSKeyValueObservation?
    var weekRangeDescriptionObservation: NSKeyValueObservation?
    let viewModel: ATMainViewModel = ATMainViewModel(apiRequestable: FakeAPIHandler())

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        initBinding()
        viewModel.getCalander()
    }

    deinit {
        canGoNextWeekkObservation?.invalidate()
        canGoLastWeekObservation?.invalidate()
        weekRangeDescriptionObservation?.invalidate()
    }
}

// MARK: - Privaite method

private extension ATMainViewController {
    func initBinding() {
        viewModel.$errorMessage(bind: self) { weakSelf, errorMessage in
            print(errorMessage)
        }

        viewModel.$isLoading(bind: self) { weakSelf, isLoading in
            if isLoading {
                HUD.show(.progress, onView: weakSelf.view)
            } else {
                HUD.hide(animated: true)
            }
        }
        viewModel.$calendar(bind: self) { weakSelf, calander in
            weakSelf.calendarView.reloadCalendarView()
        }
    }

    func setupSubViews() {
        timeZoneLabel.text = String(format: "time_display_in".localized, TimeZone.current.description)
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
        guard let calendar = viewModel.calendar else { return [] }
        return ATTimePeriod.dayTimetable(calendar: calendar, date: date)
    }
}
