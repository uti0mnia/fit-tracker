//
//  FTAddExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-07-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTAddExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet private weak var tableView: FTTableView!
    @IBOutlet private weak var addSupersetButton: FTBottomButton!
    @IBOutlet private weak var addExerciseButton: FTBottomButton!
    
    private var selectedExercises = [FTExercise]() {
        didSet {
            addSupersetButton.isEnabled = selectedExercises.count >= 2
            addExerciseButton.isEnabled = selectedExercises.count >= 1
        }
    }
    
    private let context = FTCoreDataController.shared.moc
    private lazy var frc: NSFetchedResultsController<FTExercise> = {
        let request = NSFetchRequest<FTExercise>(entityName: "FTExercise")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: "firstLetter", cacheName: nil)
        frc.delegate = self
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try frc.performFetch()
        } catch {
            assertionFailure("Yikes")
        }
    }
    
    @IBAction private func handleAddSuperset(_ sender: FTBottomButton) {
        
    }
    
    @IBAction private func handleAddExercises(_ sender: FTBottomButton) {
        
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = frc.object(at: indexPath)
        selectedExercises.append(exercise)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return frc.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections?.ft_safeAccess(at: section)?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return frc.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return frc.section(forSectionIndexTitle: title, at: index)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return frc.sectionIndexTitles.ft_safeAccess(at: section)
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet.init(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet.init(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath , let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
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
