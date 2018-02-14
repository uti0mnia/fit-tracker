//
//  ViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-29.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import SnapKit

class FTMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [UINavigationController(rootViewController: FTMainWorkoutViewController())]
    }
    
}
