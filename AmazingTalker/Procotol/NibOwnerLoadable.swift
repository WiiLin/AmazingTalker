//
//  NibOwnerLoadable.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import UIKit

protocol NibOwnerLoadable: AnyObject {
    static var nib: UINib { get }
}

extension NibOwnerLoadable {
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibOwnerLoadable where Self: UIView {
    static func loadNibContent() -> UIView {
        guard let views = Self.nib.instantiate(withOwner: self, options: nil) as? [UIView], let contentView = views.first else {
            fatalError("Fail to load \(self) nib content")
        }
        
        return contentView
    }
    
    func loadNibContent() {
        guard let views = Self.nib.instantiate(withOwner: self, options: nil) as? [UIView], let contentView = views.first else {
            fatalError("Fail to load \(self) nib content")
        }
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
