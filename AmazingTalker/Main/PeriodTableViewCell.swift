//
//  PeriodTableViewCell.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import UIKit

class PeriodTableViewCell: UITableViewCell {
    static let height: CGFloat = 21
    // MARK: - IBOutlet

    @IBOutlet private var periodLabel: UILabel!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Interface

extension PeriodTableViewCell {
    func configrure(period: Period) {
        periodLabel.text = period.range.start.string(dateFormat: "HH:mm")
        periodLabel.textColor = period.period.color
    }
}
