//
//  DayPeriodCollectionViewCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2021/7/9.
//

import UIKit

class DayPeriodCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var enableView: UIView!
    @IBOutlet private var weekDayLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var tableView: UITableView!

    // MARK: - Propreties

    private var dataSource: [Period] = []

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UINib(nibName: "\(PeriodTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(PeriodTableViewCell.self)")
        tableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        enableView.backgroundColor = .disableGray
        weekDayLabel.textColor = .disableGray
        dayLabel.textColor = .disableGray
        dataSource.removeAll()
    }
}

// MARK: - Interface

extension DayPeriodCollectionViewCell {
    func configure(_ date: Date) {
        weekDayLabel.text = date.shortWeekdaySymbol
        dayLabel.text = "\(date.day)"
        if date.moreThanOrEqualTo(Date()) {
            configurePeriods(PeriodHandler.shared.period(with: date))
        }
        tableView.reloadData()
    }
}

// MARK: - Privaite method

private extension DayPeriodCollectionViewCell {
    func configurePeriods(_ periods: [Period]) {
        enableView.backgroundColor = !periods.isEmpty ? .enableGreen : .disableGray
        weekDayLabel.textColor = !periods.isEmpty ? .textBlack : .disableGray
        dayLabel.textColor = !periods.isEmpty ? .textBlack : .disableGray
        dataSource = periods
    }
}

// MARK: - UITableViewDataSource

extension DayPeriodCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PeriodTableViewCell.self)", for: indexPath) as! PeriodTableViewCell
        cell.configrure(period: dataSource[indexPath.row])
        return cell
    }
}
