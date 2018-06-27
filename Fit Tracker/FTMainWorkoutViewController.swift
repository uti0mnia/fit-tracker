//
//  FTMainWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTMainWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    private static let workoutIdentifier = "workoutCell"
    private static let emptyIdentifier = "emptyCell"
    private static let cacheName = "workoutsCache"
    
    @IBOutlet private weak var tableView: FTTableView!
    
    private let context = FTDataController.shared.moc
    private lazy var frc: NSFetchedResultsController<FTWorkoutTemplate> = {
        let request = NSFetchRequest<FTWorkoutTemplate>(entityName: "FTWorkoutTemplate")
        request.sortDescriptors = [NSSortDescriptor(key: "isArchived", ascending: true), NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: "isArchived", cacheName: FTMainWorkoutViewController.cacheName)
        frc.delegate = self
        return frc
    }()
    
    private var hasWorkouts: Bool {
        return frc.sections?.ft_safeAccess(at: 0)?.numberOfObjects ?? 0 > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = FTColours.navigationTintColour
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.register(FTDetailCell.getNib(), forCellReuseIdentifier: FTMainWorkoutViewController.workoutIdentifier)
        tableView.register(FTEmptyWorkoutCell.self, forCellReuseIdentifier: FTMainWorkoutViewController.emptyIdentifier)
        do {
            try frc.performFetch()
        } catch {
            assertionFailure("Error performing fetch: \(error.localizedDescription)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func addWorkout(_ sender: Any) {
        let vc = UIViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.view.backgroundColor = UIColor.blue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: true)
    }
    
    private func configureWorkoutCell(_ cell: FTDetailCell, at indexPath: IndexPath) {
        let workout = frc.object(at: indexPath)
        cell.mainLabel.text = workout.name
        cell.detailLabel.text = NSString.localizedStringWithFormat(NSLocalizedString("%d exercises", comment: "") as NSString, workout.exerciseCount) as String
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let secNum = max(frc.sections?.count ?? 0, 1)
        return secNum + 1 // +1 for the quick start
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            // Quick Start
            return 1
        case 1:
            // My Workouts
            return frc.sections?.ft_safeAccess(at: 0)?.numberOfObjects ?? 1
        case 2:
            // Archived Workouts
            return frc.sections?.ft_safeAccess(at: 1)?.numberOfObjects ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FTMainWorkoutViewController.workoutIdentifier, for: indexPath) as! FTDetailCell
            cell.mainLabel?.text = "Empty Workout"
            cell.detailLabel?.text = "Quick Start. Add exercises on the fly!"
            return cell
        } else if  indexPath.section == 1 && !hasWorkouts {
            let cell = tableView.dequeueReusableCell(withIdentifier: FTMainWorkoutViewController.emptyIdentifier, for: indexPath) as! FTEmptyWorkoutCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FTMainWorkoutViewController.emptyIdentifier, for: indexPath) as! FTDetailCell
            configureWorkoutCell(cell, at: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Quick Start" }
        else if section == 1 { return "My Workouts" }
        else { return "Archived Workouts" }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !hasWorkouts && indexPath.section == 1 ? FTLayout.emptyWorkoutCellHeight : FTLayout.defaultCellHeight
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return hasWorkouts && indexPath.section == 1
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard var workouts = frc.fetchedObjects else {
            return
        }
        
        let object = workouts.remove(at: sourceIndexPath.row)
        workouts.insert(object, at: destinationIndexPath.row)
        
        // Update the indices.
        for (idx, workout) in workouts.enumerated() {
            workout.index = Int16(idx)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let workout = frc.object(at: indexPath)
//        previewViewController.workout = workout
//        navigationController?.pushViewController(previewViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(frc.object(at: indexPath))
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return hasWorkouts && indexPath.section == 1
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
