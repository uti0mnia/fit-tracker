//
//  Settings.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-08.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit

class FTSettingsManager: NSObject {
    public enum Settings: String {
        case primaryColour
    }
    
    public static let shared = FTSettingsManager()
    
    private let user = UserDefaults.standard
    
    public var primaryColour: UIColor {
        get {
            guard let colourData = user.data(forKey: Settings.primaryColour.rawValue),
                let colour = NSKeyedUnarchiver.unarchiveObject(with: colourData) as? UIColor else {
                return Colours.defaultMainPrimary
            }
            
            return colour
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            user.set(data, forKey: Settings.primaryColour.rawValue)
        }
    }
    
    private override init() {}
    
    
}
