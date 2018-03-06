//
//  FTDestructionButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTDestructionButton: UIButton {

    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    convenience init(cornerRadius: CGFloat = 0) {
        self.init(frame: CGRect.zero)
        
        self.cornerRadius = cornerRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        setTitleColor(FTColours.destructiveColour, for: .normal)
        titleLabel?.font = FTFonts.simpleButton
        backgroundColor = FTColours.lightForeground
    }

}
