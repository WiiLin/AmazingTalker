//
//  ATCalendarViewLayout.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import UIKit

class ATCalendarViewLayout: UICollectionViewFlowLayout {
    var column: CGFloat = 7.0
    func configure() {
        guard let collectionView = collectionView else { return }
        scrollDirection = .vertical
        minimumInteritemSpacing = 5
        minimumLineSpacing = 0
        sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        let totalPading: CGFloat = minimumInteritemSpacing * (column - 1)
        let width = (collectionView.frame.width - totalPading - sectionInset.left - sectionInset.right) / column
        itemSize = CGSize(width: width, height: collectionView.bounds.height)
    }

    override func prepare() {
        super.prepare()
        configure()
    }
}
