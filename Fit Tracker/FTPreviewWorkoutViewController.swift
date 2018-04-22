//
//  FTPreviewWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-04-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTPreviewWorkoutViewController: UIViewController, UITableViewDataSource {
    
    private static let previewCellReuse = "previewCellReuse"
    
    private let start = UIBarButtonItem(title: "Start", style: .plain, target: nil, action: nil)
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(FTPreviewWorkoutExerciseCell.self, forCellReuseIdentifier: previewCellReuse)
        return tableView
    }()
    
    public var workout: FTWorkoutTemplate? {
        didSet {
            self.groups = workout?.groupTemplates?.sorted(by: { return $0.index < $1.index })
        }
    }
    private var groups: [FTExerciseGroupTemplate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        assert(workout != nil, "Workout cannot be nil")
        
        tableView.reloadData()
    }
    
    private func setupVisuals() {
        view.backgroundColor = FTColours.lightBackground
        // Navigation bar.
        self.title = self.workout?.name ?? "Untitled"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        navigationController?.navigationBar.tintColor = FTColours.mainPrimary
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
    
    private func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        assert(cell.isKind(of: FTPreviewWorkoutExerciseCell.self), "Cell should be of type FTPreviewWorkoutExerciseCell")
        assert(groups != nil, "Workout doesn't have group templates")
        
        guard let cell = cell as? FTPreviewWorkoutExerciseCell, let group = groups?[indexPath.row] else {
            return
        }
        
        cell.groupTemplate = group
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTPreviewWorkoutViewController.previewCellReuse, for: indexPath)
        configure(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Exercises"
    }
    
}
