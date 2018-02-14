//
//  Colours.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-08.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class Colours: NSObject {
    
    private override init() {}
    
    // MARK: - Static Colours
    
    // Light colours.
    public static let lightPrimary = UIColor(hexString: "#F9F9F9")!
    public static let lightSecondary = UIColor(hexString: "#F5F5F5")!
    
    // Dark colours.
    public static let darkPrimary = UIColor.flatBlack
    public static let darkSecondary = UIColor(hexString: "#212121")!
    
    // Colour used for interactions or popping out.
    public static let defaultMainPrimary = UIColor.flatGreen
    
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
