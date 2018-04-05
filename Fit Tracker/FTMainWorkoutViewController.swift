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
            make.left.right.equalToSuperview().inset(FTLayout.defaultPadding)
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-FTLayout.defaultPadding)
            make.top.equalTo(tableView.snp.bottom).offset(FTLayout.defaultPadding)
            make.height.equalTo(FTLayout.defaultButtonHeight)
        }
        quickStackButton.setTitle("FTMainWorkoutViewController_QuickStart".ft_localized, for: .normal)
        
        // New workout button.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        addButton.tintColor = FTColours.mainPrimary
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc private func didTapAddButton(_ sender: Any) {
        let vc = UINavigationController(rootViewController: FTEditWorkoutExercisesViewController(context: FTDataController.shared.createMainContext()))
        navigationController?.present(vc, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            frc.managedObjectContext.delete(frc.object(at: indexPath))
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
