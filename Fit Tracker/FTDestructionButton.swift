//
//  FTDestructionButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@IBDesignable
class FTDestructionButton: FTButton {

    public override func commonInit() {
        super.commonInit()
        
        setTitleColor(FTColours.destructiveColour, for: .normal)
        titleLabel?.font = FTFonts.simpleButton
        backgroundColor = FTColours.lightForeground
    }

}
