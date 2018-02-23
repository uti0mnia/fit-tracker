//
//  FTMainWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import RealmSwift

class FTMainWorkoutViewController: UIViewController, UITableViewDataSource {
    
    private static let workoutIdentifier = "workoutIdentifier"
    private static let esitmatedCellHeight: CGFloat = 150

    private let quickStackButton = FTButtonFactory.simpleButton()
    private lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        tableView.estimatedRowHeight = FTMainWorkoutViewController.esitmatedCellHeight
        tableView.dataSource = self
        tableView.dataSource = self
        tableView.register(FTMainWorkoutTableViewCell.self, forCellReuseIdentifier: FTMainWorkoutViewController.workoutIdentifier)
        return tableView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
    }
    
    private func setupVisuals() {
        view.backgroundColor = FTColours.lightBackground
        // Navigation bar.
        self.title = "FTMainWorkoutViewController_Title".ft_localized
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // UITableView, note that if the tableView isn't the first view added, the scroll to hide large title doesn't work.
        view.addSubview(tableView)
        tableView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
        }
        
        // Quick add button.
        view.addSubview(quickStackButton)
        quickStackButton.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(FTLayout.defaultPadding)
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-FTLayout.defaultPadding)
            make.top.equalTo(tableView.snp.bottom).offset(FTLayout.defaultPadding)
            make.height.equalTo(FTLayout.defaultButtonHeight)
        }
        quickStackButton.setTitle("FTMainWorkoutViewController_QuickStart".ft_localized, for: .normal)
        
        // New workout button.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        addButton.tintColor = FTColours.mainPrimary
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc private func didTapAddButton(_ sender: Any) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTMainWorkoutViewController.workoutIdentifier, for: indexPath) as! FTMainWorkoutTableViewCell
        return cell
    }
}
