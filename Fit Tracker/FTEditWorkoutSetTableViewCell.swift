//
//  FTEditWorkoutSetTableViewCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-18.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTEditWorkoutSetTableViewCellDelegate: class {
    
}

class FTEditWorkoutSetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var weightTextField: FTDefaultTextField!
    @IBOutlet weak var weightDescriptionLabel: FTSizedLabel!
    @IBOutlet weak var repsTextField: FTDefaultTextField!
    @IBOutlet weak var repsDescriptionLabel: FTSizedLabel!
    
    public weak var delegate: FTEditWorkoutSetTableViewCellDelegate?
    
    public var setTemplate: FTSetTemplate? {
        didSet {
            guard let setTemplate = setTemplate else {
                return
            }
            
            setLabel.text = "Set \(setTemplate.index + 1)"
            let weight = setTemplate.weight
            weightTextField.placeholder = weight > 0 ? "\(setTemplate.weight.cleanString)" : nil
            let reps = setTemplate.reps
            repsTextField.placeholder = reps > 0 ? "\(setTemplate.reps)" : nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weightTextField.textAlignment = .right
        weightTextField.font = FTFonts.setTextField
        
        repsTextField.textAlignment = .right
        repsTextField.font = FTFonts.setTextField
        
        weightDescriptionLabel.font = FTFonts.setDescription
        weightDescriptionLabel.text = FTSettingsManager.shared.preferredWeight.string
        
        repsDescriptionLabel.font = FTFonts.setDescription
        repsDescriptionLabel.text = "FTGeneral_Reps".ft_localized
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
