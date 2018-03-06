//
//  FTEditWorkoutCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEditWorkoutCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    private static let setCellIdentifier = "setCellIdentifier"
    private static let addCellIdentifier = "addCellIdentifier"
    
    @IBOutlet weak var nameLabel: FTSizedLabel!
    @IBOutlet weak var setLabel: FTSizedLabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var addExerciseCell = FTButtonTableViewCell()
    
    public var exerciseGroup: FTExerciseGroupTemplate? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UINib(nibName: "FTEditWorkoutSetTableViewCell", bundle: nil), forCellReuseIdentifier: FTEditWorkoutCell.setCellIdentifier)
        addExerciseCell.button.setTitle("Add Set", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (exerciseGroup?.exerciseTemplates?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            return addExerciseCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FTEditWorkoutCell.setCellIdentifier, for: indexPath) as! FTEditWorkoutSetTableViewCell
            cell.setLabel.text = "\(indexPath.row + 1)"
            return cell
        }
    }
    
}
