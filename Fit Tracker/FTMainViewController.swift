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
        
        selectedViewController = childViewControllers[2]
        
        setupVisuals()
    }
    
    private func setupVisuals() {
        tabBar.tintColor = FTColours.mainTint
        tabBar.barTintColor = FTColours.tabBarDark
        tabBar.isTranslucent = false
    }
    
    
    
}

