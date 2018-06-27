//
//  FTCreateWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-26.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTCreateWorkoutViewController: UIViewController {
    
    public var workout: FTWorkoutTemplate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = FTColours.background
        
        navigationItem.rightBarButtonItem = editButtonItem
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
    }
    
    

}
