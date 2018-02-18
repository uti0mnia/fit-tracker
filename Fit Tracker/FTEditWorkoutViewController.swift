//
//  FTEditWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEditWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableView: UITableView = {[unowned self] in
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var dismissButton: UIBarButtonItem = {[unowned self] in
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapDismissButton(_:)))
        button.tintColor = Colours.mainPrimary
        return button
    }()
    private lazy var addButton: UIBarButtonItem = {[unowned self] in
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        button.tintColor = Colours.mainPrimary
        return button
    }()
    private let finishButton = FTButtonFactory.simpleButton()
    
    private var name: String?
    private let workout: FTWorkout
    
    
    required init(name: String? = nil, workout: FTWorkout {
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
    
    private func setupVisuals() {
        self.title = name ?? "FTEditWorkoutViewController_NewWorkout".ft_localized
        
        view.backgroundColor = Colours.lightBackground
        
        self.navigationItem.leftBarButtonItem = dismissButton
        self.navigationItem.rightBarButtonItem = addButton
        
        finishButton.titleLabel?.text = "FTGeneral_Finish".ft_localized
    }
    
    @objc private func didTapDismissButton(_ sender: UIButton) {
        
    }
    
    @objc private func didTapAddButton(_ sender: UIButton) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.exercises.count
    }
    
    
}
