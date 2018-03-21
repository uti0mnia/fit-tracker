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
            
        }
    }
    public var index: Int? {
        didSet {
            guard let index = index else {
                setLabel.text = nil
                return
            }
            
            setLabel.text = "Set \(index + 1)"
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
