//
//  FTCreateWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-26.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEditWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var infoBar: FTWorkoutInfoBar!
    @IBOutlet private weak var timerBar: FTTimerBar!
    @IBOutlet private weak var exerciseSetView: FTExerciseSetView!
    @IBOutlet weak var exerciseTableView: FTTableView!
    @IBOutlet weak var addExercisesButton: FTBottomButton!
    
    
    public var workout: FTWorkoutTemplate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = FTColours.background
        
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        
        exerciseSetView.tableView.delegate = self
        exerciseSetView.tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = editButtonItem
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        
    }
    
    

}
