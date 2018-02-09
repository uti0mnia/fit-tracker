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
    
    // Default colours
    public static let lightPrimary = UIColor.flatWhite
    public static let lightSecondary = UIColor.flatWhiteDark
    
    public static let darkPrimary = UIColor.flatBlack
    public static let darkSecondary = UIColor(hexString: "#212121")!
    
    public static let defaultMainPrimary = UIColor.flatGreen
    
    public static var mainPrimary: UIColor {
        return FTSettingsManager.shared.primaryColour
    }
}
