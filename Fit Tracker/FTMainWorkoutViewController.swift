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
    
    private static let workoutIdentifier = "workoutIdentifier"
    private static let esitmatedCellHeight: CGFloat = 150

    private let quickStackButton = FTSimpleButton()
    private lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = FTMainWorkoutViewController.esitmatedCellHeight
        tableView.register(FTMainWorkoutTableViewCell.self, forCellReuseIdentifier: FTMainWorkoutViewController.workoutIdentifier)
        return tableView
    }()
    private let context = FTDataController.shared.moc
    private lazy var frc: NSFetchedResultsController<FTWorkoutTemplate> = {
        let request = NSFetchRequest<FTWorkoutTemplate>(entityName: "FTWorkoutTemplate")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    private lazy var previewViewController = FTPreviewWorkoutViewController()
    
    private let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        do {
            try frc.performFetch()
        } catch {
            print("Error performing fetch: \(error.localizedDescription)")
            assertionFailure()
        }
    }
    
    private func setupVisuals() {
        view.backgroundColor = FTColours.lightBackground
        // Navigation bar.
        self.title = "FTMainWorkoutViewController_Title".ft_localized
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        navigationController?.navigationBar.tintColor = FTColours.mainPrimary
        
        // UITableView, note that if the tableView isn't the first view added, the scroll to hide large title doesn't work.
        view.addSubview(tableView)
        tableView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Quick add button.
        view.addSubview(quickStackButton)
        quickStackButton.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(FTLayout.mediumPadding)
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-FTLayout.mediumPadding)
            make.top.equalTo(tableView.snp.bottom).offset(FTLayout.mediumPadding)
            make.height.equalTo(FTLayout.defaultButtonHeight)
        }
        quickStackButton.setTitle("FTMainWorkoutViewController_QuickStart".ft_localized, for: .normal)
        
        // New workout button.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        addButton.tintColor = FTColours.mainPrimary
        self.navigationItem.rightBarButtonItem = addButton
        
        editButton.target = self
        editButton.action = #selector(didTapEditButton(_:))
        self.navigationItem.leftBarButtonItem = editButton
        
        doneButton.target = self
        doneButton.action = #selector(didTapDoneButton(_:))
    }
    
    @objc private func didTapAddButton(_ sender: Any) {
        let vc = UINavigationController(rootViewController: FTEditWorkoutExercisesViewController(context: FTDataController.shared.createMainContext()))
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapEditButton(_ sender: Any) {
        tableView.setEditing(true, animated: true)
        navigationItem.leftBarButtonItem = doneButton
    }
    
    @objc private func didTapDoneButton(_ sender: Any) {
        tableView.setEditing(false, animated: true)
        navigationItem.leftBarButtonItem = editButton
    }
    
    private func save() {
        FTDataController.shared.saveContext() { _ in
            // TODO: handle error
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTMainWorkoutViewController.workoutIdentifier, for: indexPath) as! FTMainWorkoutTableViewCell
        cell.workout = frc.object(at: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
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
        let workout = frc.object(at: indexPath)
        previewViewController.workout = workout
        navigationController?.pushViewController(previewViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(frc.object(at: indexPath))
        }
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
