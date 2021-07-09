//
//  ATMainViewController.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//
import PKHUD
import UIKit

class ATMainViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var lastWeekButton: UIButton!
    @IBOutlet var nextWeekButton: UIButton!
    @IBOutlet var weekRangeLabel: UILabel!
    @IBOutlet var timeZoneLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    var canGoNextWeekkObservation: NSKeyValueObservation?
    var canGoLastWeekObservation: NSKeyValueObservation?
    var weekRangeDescriptionObservation: NSKeyValueObservation?
    lazy var viewModel: ATMainViewModel = ATMainViewModel(apiRequestable: FakeAPIHandler(), date: Date())

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
        viewModel.delegate = self
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
        viewModel.$canGoLastWeek(bind: self,fireNow: true)  { weakSelf, canGoLastWeek in
            self.lastWeekButton.isEnabled = canGoLastWeek
        }
        viewModel.$canGoNextWeek(bind: self,fireNow: true)  { weakSelf, canGoNextWeek in
            self.nextWeekButton.isEnabled = canGoNextWeek
        }
        viewModel.$weekRangeDescription(bind: self)  { weakSelf, weekRangeDescription in
            self.weekRangeLabel.text = weekRangeDescription
        }
    }

    func setupSubViews() {
        collectionView.register(UINib(nibName: "\(ATDayPeriodCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ATDayPeriodCell.self)")

        timeZoneLabel.text = String(format: "time_display_in".localized, TimeZone.current.description)
    }

    @IBAction func onClickLastWeek(_ sender: Any) {
        viewModel.goLastWeek()
    }

    @IBAction func onClickNextWeek(_ sender: Any) {
        viewModel.goNextWeek()
    }
}

extension ATMainViewController {
    func getDayTimetable(date: Date) -> [ATTimePeriod] {
        guard let calendar = viewModel.calendar else { return [] }
        return ATTimePeriod.dayTimetable(calendar: calendar, date: date)
    }
}


extension ATMainViewController: ATMainViewModelDelegate {
    func reloadCalendarView() {
        collectionView.reloadData()
    }
}


extension ATMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weekDate.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ATDayPeriodCell.self)", for: indexPath) as! ATDayPeriodCell
        let date = viewModel.weekDate[indexPath.row]

        cell.configureDate(viewModel.weekDate[indexPath.row])

        if date.isPastDays {
            cell.configureDayTimetable(getDayTimetable(date: viewModel.weekDate[indexPath.row]) )
        }
        return cell
    }
}
