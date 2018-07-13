//
//  FTBottomButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-27.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTBottomButton: FTButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    public var rectCorner: UIRectCorner = [.topLeft, .topRight] {
        didSet {
            setNeedsLayout()
        }
    }
    
    private func commonInit() {
        layer.shadowColor = FTColours.buttonShadow.cgColor
        layer.shadowOpacity = FTColours.buttonShadowOpacity
        layer.shadowRadius = FTLayout.buttonShadowRadius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        buttonColour = FTColours.white
        highlightColour = FTColours.white.darken(byPercentage: 0.1)
        disabledColour = FTColours.white
        
        titleLabel?.font = FTFonts.headline
        setTitleColor(FTColours.buttonEnabled, for: .normal)
        setTitleColor(FTColours.buttonHighlighted, for: .highlighted)
        setTitleColor(FTColours.buttonDisabled, for: .disabled)
        
        contentVerticalAlignment = .top
        contentEdgeInsets = UIEdgeInsets(top: FTLayout.mediumPadding, left: 0, bottom: 0, right: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.ft_roundCorners(rectCorner, radius: FTLayout.bottomButtonCornerRadius)
    }

}
