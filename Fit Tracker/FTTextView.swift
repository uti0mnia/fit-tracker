//
//  FTTextView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-25.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        font = FTFonts.body
        allowsEditingTextAttributes = false
        
        backgroundColor = FTColours.lightForeground
    }
}
