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

    func configureDate(_ date: Date) -> Bool {
        let needConfigureDayTimetable: Bool = date.needConfigureDayTimetable
        if needConfigureDayTimetable == false {
            enableView.backgroundColor = .disableGray
            weekDayLabel.textColor = .disableGray
            dayLabel.textColor = .disableGray
        }
        weekDayLabel.text = date.weekdaySymbol
        dayLabel.text = "\(date.day)"

        return needConfigureDayTimetable
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
