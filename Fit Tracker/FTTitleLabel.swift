//
//  FTTitleView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-12.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.textColor = Colours.darkTextColour
        self.font = Fonts.title
    }
    
}
