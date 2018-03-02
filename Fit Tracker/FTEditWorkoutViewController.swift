//
//  FTEditWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTEditWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private static let editSetCell = "editSetCell"
    private static let rowHeight: CGFloat = 50
    
    private var tableView: UITableView = {
        let tv = UITableView()
        tv.register(FTEditWorkoutSetTableViewCell.self, forCellReuseIdentifier: FTEditWorkoutViewController.editSetCell)
        tv.rowHeight = FTEditWorkoutViewController.rowHeight
        return tv
    }()
    
    private lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapDismissButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    private let finishButton = FTButtonFactory.simpleButton()
    
    private var name: String?
    private var workout: FTWorkoutTemplate
    private var sets = [Int: [FTSetTemplate]]()
    private var exercises: [FTExerciseTemplate]
    
    private var context: NSManagedObjectContext
    
    required init(name: String? = nil, workout: FTWorkoutTemplate? = nil) {
        self.name = name
        
        let context = (UIApplication.shared.delegate as! AppDelegate).dataController.moc
        self.context = context
        self.workout = workout ?? FTWorkoutTemplate(context: context)
        self.exercises = workout?.exerciseTemplates?.sorted(by: { $0.index < $1.index }) ?? [FTExerciseTemplate]()
        
        super.init(nibName: nil, bundle: nil)
        
        exercises.forEach() { template in
            self.sets[Int(template.index)] = template.setTemplates?.sorted(by: { return $0.index < $1.index }) ?? [FTSetTemplate]()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: make name text field first reponder if no name.
    }
    
    private func setupVisuals() {
        self.title = name ?? "FTEditWorkoutViewController_NewWorkout".ft_localized
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        
        view.backgroundColor = FTColours.lightBackground
        
        self.navigationItem.leftBarButtonItem = dismissButton
        self.navigationItem.rightBarButtonItem = addButton
        
        finishButton.titleLabel?.text = "FTGeneral_Finish".ft_localized
    }
    
    @objc private func didTapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAddButton(_ sender: UIButton) {
        // TODO: Bring up ExerciseSelectionVC
    }
    
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        guard let cell = cell as? FTEditWorkoutSetTableViewCell else {
            return
        }
        
        // We will assume that
        cell.setTemplate = sets[indexPath.section]?[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTEditWorkoutViewController.editSetCell, for: indexPath)
        configure(cell: cell, atIndexPath: indexPath)
        return cell
        
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return exercises.map({ return $0.exercise?.name ?? "" })
    }
    
    // MARK: - UITableViewDelegate
    
}
