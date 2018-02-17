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
    
    private let workoutVC = FTMainWorkoutViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        setupViewControllers()
    }
    
    private func setupVisuals() {
        tabBar.tintColor = Colours.tabBarTintColour
        tabBar.barTintColor = Colours.tabBarBarTintColour
        tabBar.isTranslucent = false
    }
    
    private func setupViewControllers() {
        workoutVC.tabBarItem = UITabBarItem(title: "FTMainTabBar_Workout".localized, image: #imageLiteral(resourceName: "barbell"), selectedImage: #imageLiteral(resourceName: "barbell"))
        viewControllers = [UINavigationController(rootViewController: workoutVC)]
    }
    
}

