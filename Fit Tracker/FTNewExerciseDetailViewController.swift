//
//  FTNewExerciseDetailViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTNewExerciseDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private static let cellIdentifier = "cellIdentifier"
    
    public var options: [CustomStringConvertible]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {[unowned self] in
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.backgroundColor = Colours.lightBackground
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
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = true
    }

}
