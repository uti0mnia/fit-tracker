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
    private let settingsVC = FTSettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        setupViewControllers()
    }
    
    private func setupVisuals() {
        tabBar.tintColor = FTColours.tabBarTintColour
        tabBar.barTintColor = FTColours.tabBarBarTintColour
        tabBar.isTranslucent = false
    }
    
    private func setupViewControllers() {
        workoutVC.tabBarItem = UITabBarItem(title: "FTMainTabBar_Workout".ft_localized, image: #imageLiteral(resourceName: "workout"), tag:0)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), tag: 1)
        viewControllers = [
            UINavigationController(rootViewController: workoutVC),
            UINavigationController(rootViewController: settingsVC)
            ]
    }
    
}

