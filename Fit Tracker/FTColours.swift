//
//  FTColours.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-08.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class FTColours: NSObject {
    
    private override init() {}
    
    // MARK: - Static Colours
    public static let blue = UIColor(hexString: "#22A7F0")!
    public static let lightBlue = UIColor(hexString: "#E4F1FE")!
    public static let red = UIColor(hexString: "#EC644B")!
    public static let lightGreen = UIColor(hexString: "#87D37C")!
    public static let green = UIColor(hexString: "#26A65B")!
    public static let orange = UIColor(hexString: "#F89406")!
    public static let purple = UIColor(hexString: "#9B59B6")!
    public static let pink = UIColor(hexString: "#FF1654")!
    
    // TODO: More colours for supersets
    
    public static let buttonShadow = UIColor(hexString: "#000000", withAlpha: 0.2)!
    public static let buttonEnabled = FTColours.blue
    public static let buttonDisabled = FTColours.blue.withAlphaComponent(0.3)
    public static let buttonTapped = FTColours.blue.withAlphaComponent(0.7)
    
    public static let background = UIColor(hexString: "#F1F1F1")!
    
    public static let tabBarDark = UIColor(hexString: "#000000", withAlpha: 0.9)!
    
    
    
    
    
    
    
    
    
    
    
    
    // Main colours.
    public static let lightForeground = UIColor(hexString: "#F9F9F9")!
    public static let lightBackground = UIColor(hexString: "#F5F5F5")!
    public static let darkForeground = UIColor(hexString: "#212121")!
    public static let darkBackground = UIColor.flatBlack
    
    // Item colours.
    public static let tabBarTintColour = FTColours.lightBackground
    public static let tabBarBarTintColour = FTColours.darkBackground
    
    // TextColours
    public static let darkTextColour = UIColor.flatBlackDark
    public static let darkGrayTextColour = UIColor.flatGrayDark
    public static let grayTextColour = UIColor.flatGrayDark
    public static let lightTextColour = FTColours.lightBackground
    
    // Colour used for interactions or popping out.
    public static let defaultMainPrimary = FTColours.orange
    public static let destructiveColour = FTColours.red
    public static let missingColour = FTColours.red
    
    // Colours used for special things.
    public static let special = UIColor.flatRedDark
    
    // Other colours.
    public static let shadow = UIColor(hexString: "#EDEDED")!
    
    // MARK: - Variable colours
    
    // Colour used for interactions or popping out.
    public static var mainPrimary: UIColor {
        return FTSettingsManager.shared.primaryColour
    }
    
}
