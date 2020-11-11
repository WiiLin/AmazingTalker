//
//  ATTimePeriodCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/11.
//

import UIKit

class ATTimePeriodCell: UITableViewCell, NibLoadableView, ReusableView {
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configrure(timePeriod: ATTimePeriod) {
        self.timeLabel.text = timePeriod.range.start.string(dateFormat: "HH:mm")
        self.timeLabel.textColor = timePeriod.period.color
    }
    
}
