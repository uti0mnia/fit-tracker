//
//  FTNavigationManager.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-02.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTNavigationManager: NSObject, UINavigationControllerDelegate {
    
    public static let shared = FTNavigationManager()
    
    private override init() {}
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
}
