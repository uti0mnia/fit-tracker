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
    private var exerciseCountLabel: FTSizedLabel?
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
    private let finishButton = FTButtonFactory.simpleButton()
    
    private var workout: FTWorkoutTemplate
    private var sets = [Int: [FTSetTemplate]]() {
        didSet {
            self.editButton.isEnabled = sets.count > 0
        }
    }
    private var exercises: [FTExerciseTemplate] {
        didSet {
            emptyWorkoutLabel.isHidden = exercises.count > 0
            exerciseCountLabel?.text = String(format: "FTEditWorkoutViewController_ToolBarExercises".ft_localized, exercises.count)
        }
    }
    private let context: NSManagedObjectContext
    
    required init(workout: FTWorkoutTemplate? = nil) {
        let context = FTDataController.shared.createMainContext()
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
        setupToolBar()
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
        
        view.addSubview(emptyWorkoutLabel)
        emptyWorkoutLabel.text = "FTEditWorkoutViewController_EmptyWorkout".ft_localized
        emptyWorkoutLabel.snp.makeConstraints({ $0.center.equalToSuperview() })
        
        tableView.backgroundColor = UIColor.clear
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = editButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        finishButton.titleLabel?.text = "FTGeneral_Finish".ft_localized
    }
    
    private func setupToolBar() {
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        addBarButton.tintColor = FTColours.mainPrimary
        
        let label = FTSizedLabel(textSize: .small)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = String(format: "FTEditWorkoutViewController_ToolBarExercises".ft_localized, exercises.count)
        let labelBarButton = UIBarButtonItem(customView: label)
        
        navigationController?.setToolbarHidden(false, animated: false)
        toolbarItems = [leftSpace, labelBarButton, rightSpace, addBarButton]
    }
    
    @objc private func didTapDismissButton(_ sender: UIButton) {
        // TODO: Verify discard if exercises added.
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapEditButton(_ sender: UIButton) {
        
    }
    
    @objc private func didTapAddButton(_ sender: UIButton) {
        let vc = FTAddExerciseViewController()
        navigationController?.pushViewController(vc, animated: true)
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
