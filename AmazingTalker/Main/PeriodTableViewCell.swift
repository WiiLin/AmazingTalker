//
//  PeriodTableViewCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/7/9.
//

import UIKit

class PeriodTableViewCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet private var periodLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
 
//MARK: - Interface
extension PeriodTableViewCell{
    func configrure(period: Period) {
        periodLabel.text = period.range.start.string(dateFormat: "HH:mm")
        periodLabel.textColor = period.period.color
    }
}
