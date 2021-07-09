//
//  PeriodTableViewCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/7/9.
//

import UIKit

class PeriodTableViewCell: UITableViewCell {
    @IBOutlet var periodLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configrure(period: Period) {
        periodLabel.text = period.range.start.string(dateFormat: "HH:mm")
        periodLabel.textColor = period.period.color
    }
}
