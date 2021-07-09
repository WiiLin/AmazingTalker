//
//  ATTimePeriodCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/7/9.
//

import UIKit

class ATTimePeriodCell: UITableViewCell {
    @IBOutlet var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configrure(timePeriod: ATTimePeriod) {
        timeLabel.text = timePeriod.range.start.string(dateFormat: "HH:mm")
        timeLabel.textColor = timePeriod.period.color
    }
}
