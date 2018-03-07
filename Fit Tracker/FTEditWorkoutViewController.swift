//
//  FTEditWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTEditWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, FTAddExerciseViewControllerDelegate {
    
    private static let cellReuse = "editWorkoutCell"
    
    private static let sections = ["Exercises"]
    
    private var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(FTEditWorkoutCell.self, forCellReuseIdentifier: FTEditWorkoutViewController.cellReuse)
        tv.rowHeight = UITableViewAutomaticDimension
        return tv
    }()
    private var emptyWorkoutLabel = FTTitleLabel()
    
    // Navbar.
    private lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapDismissButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    private let finishButton = FTSimpleButton()
    
    private let workout: FTWorkoutTemplate
    private let context: NSManagedObjectContext
    private lazy var frc: NSFetchedResultsController<FTExerciseTemplate> = {
        let request = NSFetchRequest<FTExerciseTemplate>(entityName: "FTExerciseTemplate")
        request.sortDescriptors = [NSSortDescriptor(key: "groupTemplate.index", ascending: true), NSSortDescriptor(key: "index", ascending: true)]
        request.predicate = NSPredicate(format: "%K == %@", "groupTemplate.workoutTemplate", workout)
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    required init(workout: FTWorkoutTemplate? = nil) {
        self.context = FTDataController.shared.moc
        self.workout = workout ?? FTWorkoutTemplate(context: FTDataController.shared.moc)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: make name text field first reponder if no name.
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
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = editButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        finishButton.titleLabel?.text = "FTGeneral_Finish".ft_localized
    }
    
    private func setupToolBar() {
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        addBarButton.tintColor = FTColours.mainPrimary
        
        navigationController?.setToolbarHidden(false, animated: false)
        toolbarItems = [leftSpace, addBarButton]
    }
    
    @objc private func didTapDismissButton(_ sender: UIButton) {
        // TODO: Verify discard if exercises added.
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapEditButton(_ sender: UIButton) {
        tableView.reloadData()
    }
    
    @objc private func didTapAddButton(_ sender: UIButton) {
        let vc = FTAddExerciseViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FTEditWorkoutViewController.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTEditWorkoutViewController.cellReuse, for: indexPath) as! FTEditWorkoutCell
        let object = frc.object(at: indexPath)
        cell.exerciseTemplate = object
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FTEditWorkoutViewController.sections[section]
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(tableView.cellForRow(at: indexPath)!.intrinsicContentSize.height)
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .fade)
        case .delete:
            tableView.deleteSections(indexSet, with: .fade)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
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
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        emptyWorkoutLabel.isHidden = (frc.fetchedObjects?.count ?? 0) > 0
    }
    
    // MARK: - FTAddExerciseViewControllerDelegate
    
    func addExerciseViewController(_ controller: FTAddExerciseViewController, willDismissWithAddedExerciseGroups groups: [FTExerciseGroupTemplate]) {
        // Note that the FTExerciseGroupTemplates are pre populated (with default values) in the FTAddExerciseViewController
        var index = Int16(workout.groupTemplates?.count ?? 0)
        groups.forEach() { group in
            group.workoutTemplate = workout
            group.index = index
            index += 1
        }
    }
    
}
