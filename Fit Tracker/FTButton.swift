//
//  FTButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTButton: UIButton {
    
    public var highlightColour: UIColor = FTColours.buttonHighlighted
    public var buttonColour: UIColor = FTColours.buttonEnabled
    public var disabledColour: UIColor = FTColours.buttonDisabled
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightColour : buttonColour
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? buttonColour : disabledColour
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let height = max(self.bounds.height, FTLayout.minButtonTap)
        let width = max(self.bounds.width, FTLayout.minButtonTap)
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        return rect.contains(point)
    }

}
