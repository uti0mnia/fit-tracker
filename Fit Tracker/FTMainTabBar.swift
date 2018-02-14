//
//  FTMainTabBar.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-08.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTMainTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setVisuals()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisuals() {
        let homeItem = UITabBarItem(title: NSLocalizedString("FTMainTabBar_Home", comment: ""), image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        let workoutItem = UITabBarItem(title: NSLocalizedString("FTMainTabBar_Workout", comment: ""), image: #imageLiteral(resourceName: "barbell"), selectedImage: #imageLiteral(resourceName: "barbell"))
        let logItem = UITabBarItem(title: NSLocalizedString("FTMainTabBar_Log", comment: ""), image: #imageLiteral(resourceName: "log"), selectedImage: #imageLiteral(resourceName: "log"))
        let settingItem = UITabBarItem(title: NSLocalizedString("FTMainTabBar_Settings", comment: ""), image: #imageLiteral(resourceName: "settings"), selectedImage: #imageLiteral(resourceName: "settings"))
        
        self.setItems([homeItem, workoutItem, logItem, settingItem], animated: false)
        self.barTintColor = Colours.darkPrimary
        
    }
    
    
}
