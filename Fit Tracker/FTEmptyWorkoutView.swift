//
//  FTEmptyWorkoutCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-24.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEmptyWorkoutView: UIView {
    
    @IBOutlet public weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.font = FTFonts.body
    }
}
