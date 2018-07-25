//
//  FTDetailCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-24.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTDetailCell: UITableViewCell {
    
    @IBOutlet public weak var mainLabel: UILabel!
    @IBOutlet public weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.font = FTFonts.body
        detailLabel.textColor = FTColours.descriptionText
        detailLabel.font = FTFonts.description
        
        selectionStyle = .none
    }
    
    public static func getNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}
