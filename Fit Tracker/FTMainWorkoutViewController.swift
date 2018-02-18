//
//  FTMainWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTMainWorkoutViewController: UIViewController, UITableViewDataSource {
    
    private static let workoutIdentifier = "workoutIdentifier"
    
    let workout = FTWorkout()

    private let quickStackButton = FTButtonFactory.simpleButton()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workout.name = "Push A"
        
        setupVisuals()
    }
    
    private func setupVisuals() {
        view.backgroundColor = Colours.lightBackground
        // Navigation bar.
        self.title = "FTMainWorkoutViewController_Title".ft_localized
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // UITableView, note that if the tableView isn't the first view added, the scroll to hide large title doesn't work.
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 150
        tableView.dataSource = self
        tableView.register(FTMainWorkoutTableViewCell.self, forCellReuseIdentifier: FTMainWorkoutViewController.workoutIdentifier)
        tableView.dataSource = self
        tableView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
        }
        
        // Quick add button.
        view.addSubview(quickStackButton)
        quickStackButton.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(Layout.defaultPadding)
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-Layout.defaultPadding)
            make.top.equalTo(tableView.snp.bottom).offset(Layout.defaultPadding)
            make.height.equalTo(Layout.defaultButtonHeight)
        }
        quickStackButton.setTitle("FTMainWorkoutViewController_QuickStart".ft_localized, for: .normal)
        
        // New workout button.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        addButton.tintColor = Colours.mainPrimary
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc private func didTapAddButton(_ sender: Any) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTMainWorkoutViewController.workoutIdentifier, for: indexPath) as! FTMainWorkoutTableViewCell
        cell.workout = workout
        return cell
    }
}
