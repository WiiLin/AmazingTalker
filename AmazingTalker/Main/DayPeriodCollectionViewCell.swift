//
//  DayPeriodCollectionViewCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
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
    func configure(date: Date, periods: [Period]) {
        weekDayLabel.text = date.shortWeekdaySymbol
        dayLabel.text = "\(date.day)"
        configurePeriods(periods)
        tableView.reloadData()
    }
}

// MARK: - Privaite method

private extension DayPeriodCollectionViewCell {
    func configurePeriods(_ periods: [Period]) {
        enableView.backgroundColor = !periods.filter{ $0.period == .available }.isEmpty ? .enableGreen : .disableGray
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


extension DayPeriodCollectionViewCell {
    class func cellSize(periods:[Period]) -> CGSize {
        let enableViewHeight: CGFloat = 4
        let dateViewTopPadding: CGFloat = 10
        let dateViewHeight: CGFloat = 46
        let dateViewBottomPadding: CGFloat = 10
        let periodsHeight = CGFloat(periods.count) * PeriodTableViewCell.height
        let totalHeight: CGFloat = enableViewHeight + dateViewHeight + dateViewTopPadding + dateViewBottomPadding + periodsHeight
        return CGSize(width: TimetableCollectionViewLayout.itemWidth, height: totalHeight)
    }
}


