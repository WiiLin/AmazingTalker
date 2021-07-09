//
//  MainViewController.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//
import PKHUD
import UIKit

class MainViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var lastWeekButton: UIButton!
    @IBOutlet var nextWeekButton: UIButton!
    @IBOutlet var weekRangeLabel: UILabel!
    @IBOutlet var timeZoneLabel: UILabel!
    @IBOutlet var timetableCollectionView: UICollectionView!

    lazy var viewModel: MainViewModel = MainViewModel(apiRequestable: FakeAPIHandler(), beginDate: Date())

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        initBinding()
        viewModel.getCalander()
    }
}

// MARK: - Privaite method

private extension MainViewController {
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
        viewModel.$canGoLastWeek(bind: self, fireNow: true) { weakSelf, canGoLastWeek in
            self.lastWeekButton.isEnabled = canGoLastWeek
        }
        viewModel.$canGoNextWeek(bind: self, fireNow: true) { weakSelf, canGoNextWeek in
            self.nextWeekButton.isEnabled = canGoNextWeek
        }
        viewModel.$weekRangeDescription(bind: self) { weakSelf, weekRangeDescription in
            self.weekRangeLabel.text = weekRangeDescription
        }
    }

    func setupSubViews() {
        timetableCollectionView.register(UINib(nibName: "\(DayPeriodCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(DayPeriodCollectionViewCell.self)")
        timeZoneLabel.text = String(format: "time_display_in".localized, TimeZone.current.description)
    }

    @IBAction func onClickLastWeek(_ sender: Any) {
        viewModel.goLastWeek()
    }

    @IBAction func onClickNextWeek(_ sender: Any) {
        viewModel.goNextWeek()
    }
}

// MARK: - ATMainViewModelDelegate

extension MainViewController: MainViewModelDelegate {
    func didChangeWeek() {
        timetableCollectionView.reloadData()
    }

    func didFinishedLoadTimetable() {
        timetableCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.week.dates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DayPeriodCollectionViewCell.self)", for: indexPath) as! DayPeriodCollectionViewCell
        let date = viewModel.week.dates[indexPath.row]
        cell.configure(date)
        return cell
    }
}
