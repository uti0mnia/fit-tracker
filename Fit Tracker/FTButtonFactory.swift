//
//  FTButtonFactory.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-18.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit

class FTButtonFactory: NSObject {
    
    public enum Size {
        case small, regular, large
        
        public var height: CGFloat {
            switch self {
            case .small:
                return FTLayout.buttonSmall
            case .regular:
                return FTLayout.buttonRegular
            case .large:
                return FTLayout.buttonLarge
            }
        }
    }
    
    public func createEmphasized(size: Size) -> FTButton {
        let button = FTButton(type: .custom)
        button.layer.cornerRadius = roundToPixel(size.height / 2)
        
        button.buttonColour = FTColours.buttonEnabled
        button.highlightColour = FTColours.buttonHighlighted
        
        button.titleLabel?.font = FTFonts.headline
        button.titleLabel?.textColor = FTColours.buttonTextLight
        button.setTitleColor(FTColours.buttonTextLight, for: .normal)
        return button
    }
    
    public func createDeemphasized(size: Size) -> FTButton {
        let button = FTButton(type: .custom)
        button.layer.cornerRadius = roundToPixel(size.height / 2)
        
        button.layer.shadowColor = FTColours.buttonShadow.cgColor
        button.layer.shadowOpacity = FTColours.buttonShadowOpacity
        button.layer.shadowRadius = FTLayout.buttonShadowRadius
        
        
        button.buttonColour = FTColours.white
        button.highlightColour = FTColours.white
        
        button.titleLabel?.font = FTFonts.headline
        button.setTitleColor(FTColours.buttonEnabled, for: .normal)
        button.setTitleColor(FTColours.buttonHighlighted, for: .highlighted)
        button.setTitleColor(FTColours.buttonDisabled, for: .disabled)
        
        return button
    }
    
    // TODO: do it
    public func createInfoBar() -> FTButton {
        let button = FTButton(type: .custom)
        button.layer.cornerRadius = FTLayout.infoBarCornerRadius
        
        button.layer.shadowColor = FTColours.infoBarShadow.cgColor
        button.layer.shadowOpacity = FTColours.infoBarShadowOpacity
        button.layer.shadowRadius = FTLayout.infoBarShadowRadius
        
        button.backgroundColor = FTColours.background
        button.highlightColour = FTColours.buttonHighlighted
        
        button.tintColor = FTColours.mainTint
        
        return button
    }
    
}
