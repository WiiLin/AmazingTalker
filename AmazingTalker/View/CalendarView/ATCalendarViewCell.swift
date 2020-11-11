//
//  ATCalendarViewCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import UIKit

class ATCalendarViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    @IBOutlet var enableView: UIView!
    @IBOutlet var weekDayLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(ATTimePeriodCell.self)
            tableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        }
    }

    var dataSource: [ATTimePeriod] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        enableView.backgroundColor = .disableGray
        weekDayLabel.textColor = .disableGray
        dayLabel.textColor = .disableGray
    }

    func configureDate(_ date: Date) {
        weekDayLabel.text = date.shortWeekdaySymbol
        dayLabel.text = "\(date.day)"
    }

    func configureDayTimetable(_ timePeriod: [ATTimePeriod]) {
        enableView.backgroundColor = !timePeriod.isEmpty ? .enableGreen : .disableGray
        weekDayLabel.textColor = !timePeriod.isEmpty ? .textBlack : .disableGray
        dayLabel.textColor = !timePeriod.isEmpty ? .textBlack : .disableGray
        dataSource = timePeriod
        tableView.reloadData()
    }
}

extension ATCalendarViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ATTimePeriodCell
        cell.configrure(timePeriod: dataSource[indexPath.row])
        return cell
    }
}
