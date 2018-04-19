//
//  FTPreviewWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-04-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTPreviewWorkoutViewController: UIViewController {
    
    private let start = UIBarButtonItem(title: "Start", style: .plain, target: nil, action: nil)
    
    private let workout: FTWorkoutTemplate
    
    required init(workout: FTWorkoutTemplate) {
        self.workout = workout
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
    }
    
    private func setupVisuals() {
        view.backgroundColor = FTColours.lightBackground
        // Navigation bar.
        self.title = self.workout.name ?? "Untitled"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        navigationController?.navigationBar.tintColor = FTColours.mainPrimary
        
        // TODO: setup tableview + cells for previewing.
    }
    
}
