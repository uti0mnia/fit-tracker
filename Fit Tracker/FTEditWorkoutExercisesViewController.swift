//
//  FTEditWorkoutExercisesViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTEditWorkoutExercisesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, FTAddExerciseViewControllerDelegate {
    
    private static let cellReuse = "editWorkoutCell"
    
    private static let sections = ["Exercises"]
    private static let estimatedHeaderViewHeight: CGFloat = 60
    
    private var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(FTEditWorkoutCell.self, forCellReuseIdentifier: FTEditWorkoutExercisesViewController.cellReuse)
        tv.rowHeight = UITableViewAutomaticDimension
        return tv
    }()
    private var emptyWorkoutLabel = FTTitleLabel()
    private var headerView = FTEditWorkoutHeaderView(title: "Exercises")
    
    // Navbar.
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    
    @objc private let workout: FTWorkoutTemplate
    private let context: NSManagedObjectContext
    private lazy var frc: NSFetchedResultsController<FTExerciseGroupTemplate> = {
        let request: NSFetchRequest<FTExerciseGroupTemplate> = FTExerciseGroupTemplate.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        request.predicate = NSPredicate(format: "%K == %@", "workoutTemplate", workout)
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    private var didEditWorkout = false
    
    required init(workout: FTWorkoutTemplate? = nil, context: NSManagedObjectContext) {
        self.context = context
        self.workout = workout ?? FTWorkoutTemplate(context: context)
        
        super.init(nibName: nil, bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        setupToolBar()
        
        do {
            try frc.performFetch()
        } catch {
            print("Error fetching objects: \(error.localizedDescription)")
            assertionFailure()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    
    private func setupVisuals() {
        self.title = workout.name ?? "FTEditWorkoutViewController_NewWorkout".ft_localized
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            tableView.contentInsetAdjustmentBehavior = .always // Make sure the large title hiding is janky af.
        }
        view.backgroundColor = FTColours.lightBackground
        
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(FTLayout.defaultInsets)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(FTLayout.defaultPadding)
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-FTLayout.defaultPadding)
        }
        
        view.addSubview(emptyWorkoutLabel)
        emptyWorkoutLabel.text = "FTEditWorkoutViewController_EmptyWorkout".ft_localized
        emptyWorkoutLabel.snp.makeConstraints({ $0.center.equalToSuperview() })
        
        navigationItem.rightBarButtonItem = editButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        headerView.addButton.addTarget(self, action: #selector(didTapAddExercise(_:)), for: .touchUpInside)
    }
    
    private func setupToolBar() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapNextButton(_:)))
        nextButton.tintColor = FTColours.mainPrimary
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapCancelButton(_:)))
        trashButton.tintColor = FTColours.destructiveColour
        
        navigationController?.setToolbarHidden(false, animated: false)
        toolbarItems = [trashButton, flexSpace, nextButton]
    }
    
    @objc private func didTapCancelButton(_ sender: UIButton) {
        guard didEditWorkout else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete your changes?", preferredStyle: .alert)
        let discard = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.context.rollback()
            self.dismiss(animated: true, completion: nil)
        }
        let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(discard)
        alert.addAction(no)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapEditButton(_ sender: UIButton) {
        tableView.setEditing(true, animated: true)
        navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    @objc private func didTapDoneButton(_ sender: UIButton) {
        tableView.setEditing(false, animated: true)
        navigationItem.setRightBarButton(editButton, animated: true)
    }
    
    @objc private func didTapAddExercise(_ sender: UIButton) {
        let vc = FTAddExerciseViewController(context: context)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapNextButton(_ sender: UIBarButtonItem) {
        let vc = FTEditWorkoutDetailsViewController(workout: workout, context: context)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func deleteExerciseGroup(at indexPath: IndexPath) {
        context.delete(frc.object(at: indexPath))
        
        if let groups = frc.fetchedObjects {
            for (idx, group) in groups.enumerated() {
                group.index = Int16(idx)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FTEditWorkoutExercisesViewController.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTEditWorkoutExercisesViewController.cellReuse, for: indexPath) as! FTEditWorkoutCell
        let group = frc.object(at: indexPath)
        cell.exerciseGroup = group
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FTEditWorkoutExercisesViewController.sections[section]
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return FTEditWorkoutExercisesViewController.estimatedHeaderViewHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteExerciseGroup(at: indexPath)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard var groups = frc.fetchedObjects else {
            return
        }
        
        let object = groups.remove(at: sourceIndexPath.row)
        groups.insert(object, at: destinationIndexPath.row)
        
        // Update the indices.
        for (idx, group) in groups.enumerated() {
            group.index = Int16(idx)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        // Do nothing (no sectioning currently).
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        didEditWorkout = true
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.deleteRows(at: [indexPath], with: .none)
                tableView.insertRows(at: [newIndexPath], with: .none)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        emptyWorkoutLabel.isHidden = (frc.fetchedObjects?.count ?? 0) > 0
    }
    
    // MARK: - FTAddExerciseViewControllerDelegate
    
    func addExerciseViewController(_ controller: FTAddExerciseViewController, willDismissWithAddedExerciseGroups groups: [FTExerciseGroupTemplate]) {
        var index = Int16(workout.groupTemplates?.count ?? 0)
        groups.forEach() { group in
            group.index = index
            index += 1
        }
        workout.addToGroupTemplates(NSSet(array: groups))
    }
    
    func addExerciseViewController(_ controller: FTAddExerciseViewController, willDismissWithAddedSupersetGroup group: FTExerciseGroupTemplate) {
        group.index = Int16(workout.groupTemplates?.count ?? 0)
        workout.addToGroupTemplates(group)
    }
    
}