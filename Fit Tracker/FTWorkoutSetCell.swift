//
//  FTWorkoutSetCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-27.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTWorkoutSetCell: UITableViewCell {
    
    @IBOutlet weak var accessoryButton: FTButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var repsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberLabel.font = FTFonts.body
        numberLabel.textColor = FTColours.setNumber
        
        selectionStyle = .none
    }
    
    public static func getNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    public func setWeight(_ weight: Double, unit: String, filled: Bool) {
        weightLabel.attributedText = FTStringFormatter.shared.formatWorkoutSetString(amount: weight, value: unit, filled: filled)
    }
    
    public func setReps(_ reps: Int, filled: Bool) {
        repsLabel.attributedText = FTStringFormatter.shared.formatWorkoutSetString(amount: Double(reps), value: "REPS", filled: filled)
    }

}
