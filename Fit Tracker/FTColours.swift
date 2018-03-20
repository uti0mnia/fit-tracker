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
    public static let red = UIColor(hexString: "#FF3B30")!
    public static let orange = UIColor(hexString: "#FF9500")!
    public static let yellow = UIColor(hexString: "#FFCC00")!
    public static let green = UIColor(hexString: "#4CD964")!
    public static let tealBlue = UIColor(hexString: "#5AC8FA")!
    public static let blue = UIColor(hexString: "#007AFF")!
    public static let purple = UIColor(hexString: "#5856D6")!
    public static let pink = UIColor(hexString: "#FF2D55")!
    
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
