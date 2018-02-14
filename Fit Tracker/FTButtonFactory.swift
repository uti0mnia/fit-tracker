//
//  FTButton.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTButtonFactory: NSObject {
    
    private override init() { }
    
    public static func simpleButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(Colours.mainPrimary, for: .normal)
        button.titleLabel?.font = Fonts.simpleButton
        print(Colours.mainPrimary)
        button.backgroundColor = Colours.lightPrimary
        
        button.layer.shadowOffset = Layout.buttonShadowOffset
        button.layer.shadowColor = Colours.shadow.cgColor
        button.layer.cornerRadius = Layout.buttonCornerRadius
        
        return button
    }
}
