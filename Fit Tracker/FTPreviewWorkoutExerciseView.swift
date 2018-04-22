//
//  FTPreviewWorkoutExerciseCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 4/19/18.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTPreviewWorkoutExerciseView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet private weak var setCountLabel: UILabel!
    
    public var numberOfSets = 0 {
        didSet {
            setCountLabel.text = "x\(numberOfSets)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.font = FTFonts.medium
        detailLabel.font = FTFonts.small
        detailLabel.textColor = FTColours.grayTextColour
        setCountLabel.font = FTFonts.title
    }
    
}
