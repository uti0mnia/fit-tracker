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
        case preferredRestTime
        case preferredWeight
        case preferredDistance
    }
    
    public enum Weight: Int {
        case lbs
        case kilo
        
        var string: String {
            switch self {
            case .lbs:
                return "lbs"
            case .kilo:
                return "kg"
            }
        }
    }
    
    public enum Distance: Int {
        case km
        case mile
        
        var string: String {
            switch self {
            case .km:
                return "km"
            case .mile:
                return "mi"
            }
        }
    }
    
    public static let shared = FTSettingsManager()
    
    private let user = UserDefaults.standard
    
    private override init() {}
    
    public var primaryColour: UIColor {
        get {
            guard let colourData = user.data(forKey: Settings.primaryColour.rawValue),
                let colour = NSKeyedUnarchiver.unarchiveObject(with: colourData) as? UIColor else {
                return FTColours.blue
            }
            
            return colour
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            user.set(data, forKey: Settings.primaryColour.rawValue)
        }
    }
    
    // In seconds.
    public var preferredRestTime: Int {
        get {
            let time = user.integer(forKey: Settings.preferredRestTime.rawValue)
            return (time <= 0) ? FTGlobals.defaultRestTime : time // We need to limit the minimum rest time to 15 or else this fails.
        }
        set {
            user.set(newValue, forKey: Settings.preferredRestTime.rawValue)
        }
    }
    
    public var preferredWeight: Weight {
        get {
            return Weight.init(rawValue: user.integer(forKey: Settings.preferredWeight.rawValue)) ?? .lbs
        }
        set {
            user.set(preferredWeight.rawValue, forKey: Settings.preferredWeight.rawValue)
        }
    }
    
    public var preferredDistance: Distance {
        get {
            return Distance.init(rawValue: user.integer(forKey: Settings.preferredDistance.rawValue)) ?? .km
        }
        set {
            user.set(preferredDistance.rawValue, forKey: Settings.preferredDistance.rawValue)
        }
    }
}
