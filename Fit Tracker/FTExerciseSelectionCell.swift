//
//  FTExerciseSelectionCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTExerciseSelectionCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: FTSizedLabel!
    @IBOutlet weak var detailLabel: FTSizedLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.textSize = .large
        
        detailLabel.textColor = FTColours.grayTextColour
        detailLabel.textSize = .large
    }
    
}
