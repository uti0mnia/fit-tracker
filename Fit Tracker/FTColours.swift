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
    public static let white = UIColor.white
    public static let blue = UIColor(hexString: "#22A7F0")!
    public static let lightBlue = UIColor(hexString: "#E4F1FE")!
    public static let red = UIColor(hexString: "#EC644B")!
    public static let lightGreen = UIColor(hexString: "#87D37C")!
    public static let green = UIColor(hexString: "#26A65B")!
    public static let orange = UIColor(hexString: "#F89406")!
    public static let purple = UIColor(hexString: "#9B59B6")!
    public static let pink = UIColor(hexString: "#FF1654")!
    
    // TODO: More colours for supersets
    
    // Global
    public static let mainTint = FTColours.blue
    
    public static let background = UIColor(hexString: "#F1F1F1")!
    
    public static let tabBarDark = UIColor(hexString: "#000000", withAlpha: 0.9)!
    
    // Buttons
    public static let buttonShadow = UIColor(hexString: "#000000")!
    public static let buttonShadowOpacity: Float = 0.3
    public static let buttonEnabled = FTColours.blue
    public static let buttonDisabled = FTColours.blue.withAlphaComponent(0.3)
    public static let buttonHighlighted = UIColor(hexString: "#4687AB")!
    public static let buttonTextLight = FTColours.lightBlue
    public static let buttonTextDark = FTColours.blue
    
    // Navigation
    public static let navigationTintColour = FTColours.blue
    
    // Text
    public static let descriptionText = UIColor(hexString: "#999999")!
    public static let workoutSetUnfilled = UIColor(hexString: "#B9B9BC")!
    
    // Info bar
    public static let infoBarShadow = UIColor(hexString: "#000000")!
    public static let infoBarShadowOpacity: Float = 0.3
    
    // Timer bar
    public static let timerBarBackground = UIColor(hexString: "#ECECEC")!
    
    // Workout sets
    public static let setNumber = UIColor(hexString: "#89C4F4")!
    
}
