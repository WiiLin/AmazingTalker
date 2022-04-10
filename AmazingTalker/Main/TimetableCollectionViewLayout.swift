//
//  TimetableCollectionViewLayout.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2022/4/10.
//

import UIKit
import AlignedCollectionViewFlowLayout

class TimetableCollectionViewLayout: AlignedCollectionViewFlowLayout {
    static let column: CGFloat = 7.0
    static let minimumInteritemSpacing: CGFloat = 7.0
    static let sectionInset: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
    static let itemWidth: CGFloat = {
        let totalPading: CGFloat = minimumInteritemSpacing * (TimetableCollectionViewLayout.column - 1)
        let width = (UIScreen.main.bounds.width - totalPading - sectionInset.left - sectionInset.right) / column
        return width
    }()
    private func configure() {
        scrollDirection = .vertical
        verticalAlignment = .top
        minimumInteritemSpacing = TimetableCollectionViewLayout.minimumInteritemSpacing
        sectionInset = TimetableCollectionViewLayout.sectionInset
//        itemSize = CGSize(width: TimetableCollectionViewLayout.itemWidth, height: collectionView.bounds.height)
    }

    override func prepare() {
        super.prepare()
        configure()
    }
}
