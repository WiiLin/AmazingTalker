//
//  ATMainViewController.swift
//  AmazingTalker
//
//  Created by Wii Lin on 2020/11/10.
//

import UIKit

class ATMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ATAPIManager.shared.getCalendar { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let calendar):
                print("calendar")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        // Do any additional setup after loading the view.
    }


}

