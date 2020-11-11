//
//  ATCalendarViewCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import UIKit

class ATCalendarViewCell: UICollectionViewCell, NibLoadableView, ReusableView  {

    @IBOutlet weak var enableView: UIView!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
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
        enableView.backgroundColor = needConfigureDayTimetable ? .enableGreen : .disableGray
        weekDayLabel.textColor = needConfigureDayTimetable ? .textBlack : .disableGray
        dayLabel.textColor = needConfigureDayTimetable ? .textBlack : .disableGray
        
        weekDayLabel.text = date.weekdaySymbol
        dayLabel.text = "\(date.day)"
        
        return needConfigureDayTimetable
    }
    
    func configureDayTimetable(_ timePeriod: [ATTimePeriod]) {
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
