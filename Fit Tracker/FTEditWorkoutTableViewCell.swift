//
//  FTEditWorkoutTableViewCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTEditWorkoutTableViewCellDelegate: class {
    func editWorkoutTableViewCell(_ cell: FTEditWorkoutTableViewCell, didAddSet: FTSetTemplate)
    func editWorkoutTableViewCell(_ cell: FTEditWorkoutTableViewCell, didRemoveSet: FTSetTemplate)
    func editWorkoutTableViewCell(_ cell: FTEditWorkoutTableViewCell, didUpdateSet: FTSetTemplate)
}

class FTEditWorkoutTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    private static let setCellIdentifier = "setCellIdentifier"
    
    private let nameLabel = FTSizedLabel()
    private let addSetButton = FTButtonFactory.simpleButton()
    
    private lazy var tableView: UITableView = {[unowned self] in
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - UITableViewDataSource
    
    // MARK: - UITableViewDelegate
}
