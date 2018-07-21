//
//  FTExerciseSetViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-28.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTExerciseSetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FTExerciseSetViewDelegate {
    
    private static let workoutSetIdentifier = "workoutSetIdentifier"
    private static let addSetIdentifier = "addSetIdentifier"
    
    private let exerciseSetView = FTExerciseSetView()
    
    public var exercise: FTAbstractExercise? {
        didSet {
            sets = exercise?.sets?.sorted(by: { $0.index < $1.index }) ?? [FTAbstractSet]()
        }
    }
    private var sets = [FTAbstractSet]()

    override func viewDidLoad() {
        super.viewDidLoad()

        exerciseSetView.frame = view.bounds
        exerciseSetView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        exerciseSetView.delegate = self
        
        exerciseSetView.tableView.delegate = self
        exerciseSetView.tableView.register(FTWorkoutSetCell.getNib(), forCellReuseIdentifier: FTExerciseSetViewController.workoutSetIdentifier)
        exerciseSetView.tableView.register(FTImageLabelCell.self, forCellReuseIdentifier: FTExerciseSetViewController.addSetIdentifier)
        exerciseSetView.tableView.rowHeight = FTLayout.workoutSetCellHeight
        
        exerciseSetView.exerciseLabel.text = exercise?.exercise?.name
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count + 1 // +1 for Add Set
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == sets.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: FTExerciseSetViewController.addSetIdentifier, for: indexPath) as! FTImageLabelCell
            cell.icon.image = #imageLiteral(resourceName: "add")
            cell.label.text = "Add Set"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FTExerciseSetViewController.workoutSetIdentifier, for: indexPath) as! FTWorkoutSetCell
            cell.numberLabel.text = "\(indexPath.row)"
            let set = sets[indexPath.row]
            
            return cell
        }
    }
    
    // MARK: - FTExerciseSetViewDelegate
    
    func exerciseSetViewDidSelectWorkoutTab(_ exerciseSetView: FTExerciseSetView) {
        // TODO: load tableview with exercise sets
    }
    
    func exerciseSetViewDidSelectPreviousTab(_ exerciseSetView: FTExerciseSetView) {
        // TODO: load tableview with previous sets
    }
    

}
