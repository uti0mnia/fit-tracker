//
//  FTWorkoutInfoBarButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-07-11.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTWorkoutInfoBarButton: FTButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        highlightColour = FTColours.buttonWorkoutBar.darken(byPercentage: 0.2)
        buttonColour = FTColours.buttonWorkoutBar
        disabledColour = FTColours.buttonWorkoutBar
        
        imageView?.contentMode = .scaleAspectFit
        let inset = (FTLayout.infoBarItemHeight - FTLayout.infoBarItemIconSize) / 2
        imageEdgeInsets = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
        
        layer.cornerRadius = FTLayout.infoBarCornerRadius
        layer.shadowColor = FTColours.infoBarShadow.cgColor
        layer.shadowRadius = FTLayout.infoBarShadowRadius
        layer.shadowOpacity = FTColours.infoBarShadowOpacity
        layer.shadowOffset = CGSize.zero
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

}
