//
//  FTEditWorkoutCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEditWorkoutCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    private static let setCellIdentifier = "editWorkoutSetCell"
    private static let addCellIdentifier = "addCellIdentifier"
    private static let rowHeight: CGFloat = 50
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet private weak var nameLabel: FTSizedLabel!
    @IBOutlet private weak var setLabel: FTSizedLabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var addExerciseCell = FTButtonTableViewCell()
    
    public var exerciseTemplate: FTExerciseTemplate? {
        didSet {
            nameLabel.text = exerciseTemplate?.exercise?.name
            setLabel.text = "\(exerciseTemplate?.setTemplates?.count ?? 0) Sets"
            
            // Reloading tableview
            let cellCount = (exerciseTemplate?.setTemplates?.count ?? 0) + 1
            tableView.frame.size = CGSize(width: tableView.frame.width, height: tableView.rowHeight * CGFloat(cellCount))
            print("table view: \(tableView.frame)")
            tableView.reloadData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UINib(nibName: "FTEditWorkoutSetTableViewCell", bundle: nil), forCellReuseIdentifier: FTEditWorkoutCell.setCellIdentifier)
        tableView.rowHeight = FTEditWorkoutCell.rowHeight
        tableView.isScrollEnabled = false
        
        addExerciseCell.button.setTitle("Add Set", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Table view in FTEditWorkoutCell calling numberOfRowsInSection")
        return (exerciseTemplate?.setTemplates?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            print("Returning default add exercise cell")
            return addExerciseCell
        } else {
            print("Preparing FTEditWorkoutSetTAbleViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: FTEditWorkoutCell.setCellIdentifier, for: indexPath) as! FTEditWorkoutSetTableViewCell
            cell.setLabel.text = "\(indexPath.row + 1)"
            return cell
        }
    }
    
}
