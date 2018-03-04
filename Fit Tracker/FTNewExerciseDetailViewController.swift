//
//  FTNewExerciseDetailViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTNewExerciseDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    public enum FTNewExerciseDetailType {
        case bodyPart
        case category
    }
    
    private static let cellIdentifier = "cellIdentifier"
    
    public var options: [CustomStringConvertible]? {
        didSet {
            tableView.reloadData()
        }
    }
    public var exercise: FTExercise?
    public var detailType: FTNewExerciseDetailType?
    public var selectedIndex: Int?
    private var selectedIndexPath: IndexPath {
        return IndexPath(row: selectedIndex ?? 0, section: 0)
    }
    
    private lazy var tableView: UITableView = {[unowned self] in
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.backgroundColor = FTColours.lightBackground
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.contentInset = UIEdgeInsetsMake(FTLayout.bigPadding, 0, 0, 0)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FTNewExerciseDetailViewController.cellIdentifier)
    }
    
    private func updateExercise() {
        guard let type = detailType, let index = selectedIndex else {
            assertionFailure("Type/Selected index should be set when using this view controller")
            return
        }
        
        switch type {
        case .bodyPart:
            exercise?.bodyPart = Int16(index)
        case .category:
            exercise?.category = Int16(index)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Reset so if the VC is resused there's an error if someone forgets to set it.
        detailType = nil
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTNewExerciseDetailViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(options?[indexPath.row] ?? "")"
        cell.accessoryType = indexPath == selectedIndexPath ? .checkmark : .none
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath != selectedIndexPath else {
            return
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        
        selectedIndex = indexPath.row
        
        updateExercise()
    }

}
