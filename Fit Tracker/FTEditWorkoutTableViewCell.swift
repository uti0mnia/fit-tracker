//
//  FTEditWorkoutTableViewCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTEditWorkoutTableViewCellDelegate: class {
    func editWorkoutTableViewCellDidTapAddSet(_ cell: FTEditWorkoutTableViewCell)
    func editWorkoutTableViewCell(_ cell: FTEditWorkoutTableViewCell, didRemoveSet: Int)
    func editWorkoutTableViewCell(_ cell: FTEditWorkoutTableViewCell, didChangeRepsForSet)
}

class FTEditWorkoutTableViewCell: UITableViewCell {
    
    
    
}
