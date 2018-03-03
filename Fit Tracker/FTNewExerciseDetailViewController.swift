//
//  FTNewExerciseDetailViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTNewExerciseDetailViewControllerDelegate: class {
    func newExerciseDetailViewController(_ viewController: FTNewExerciseViewController, willDismissWithSelectedIndexPath indexPath: IndexPath?)
}

class FTNewExerciseDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private static let cellIdentifier = "cellIdentifier"
    
    public weak var delegate: FTNewExerciseDetailViewControllerDelegate?
    
    public var options: [CustomStringConvertible]? {
        didSet {
            tableView.reloadData()
        }
    }
    public var selectedIndex: IndexPath?
    
    
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
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FTNewExerciseDetailViewController.cellIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTNewExerciseDetailViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(options?[indexPath.row] ?? "")"
        cell.accessoryType = indexPath == selectedIndex ? .checkmark : .none
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath != selectedIndex else {
            return
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if let index = selectedIndex {
            tableView.cellForRow(at: index)?.accessoryType = .none
        }
        selectedIndex = indexPath
    }

}
