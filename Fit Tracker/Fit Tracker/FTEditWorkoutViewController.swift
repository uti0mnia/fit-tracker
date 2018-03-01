//
//  FTEditWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEditWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private static let editSetCell = "editSetCell"
    private static let rowHeight: CGFloat = 50
    
    private lazy var tableView: UITableView = {[unowned self] in
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(FTEditWorkoutSetTableViewCell.self, forCellReuseIdentifier: FTEditWorkoutViewController.editSetCell)
        tv.rowHeight = FTEditWorkoutViewController.rowHeight
        return tv
    }()
    
    private lazy var dismissButton: UIBarButtonItem = {[unowned self] in
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapDismissButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    private lazy var addButton: UIBarButtonItem = {[unowned self] in
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        button.tintColor = FTColours.mainPrimary
        return button
    }()
    private let finishButton = FTButtonFactory.simpleButton()
    
    private var name: String?
    private let workout: FTWorkoutTemplate
    
    
    required init(name: String? = nil, workout: FTWorkoutTemplate) {
        self.name = name
        self.workout = workout
        
        super.init(nibName: nil, bundle: nil)
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
        cell.setTemplate = workout.exercises[indexPath.section].setTemplates[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return workout.exercises.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.exercises[section].setTemplates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTEditWorkoutViewController.editSetCell, for: indexPath)
        configure(cell: cell, atIndexPath: indexPath)
        return cell
        
    }
    
    // UITableViewDelegate
    
    
}
