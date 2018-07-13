//
//  FTStringFormatter.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import SwiftRichString

class FTStringFormatter: NSObject {
    
    public static let shared = FTStringFormatter()
    
    override private init() {}
    
    public func formatAsMinutes(seconds: Int) -> String {
        let m = Int(seconds/60)
        let s = seconds - 60 * m
        return String(format: "%i:%02d", m, s)
    }
    
    public func formatWorkoutSetString(amount: Double, value: String, filled: Bool = false) -> NSAttributedString {
        let normal = Style {
            $0.font = FTFonts.small
        }
        
        let bold = Style {
            $0.font = FTFonts.headline
            $0.color = filled ? UIColor.black : FTColours.workoutSetUnfilled
        }
        
        let group = StyleGroup(base: normal, ["bold": bold])
        let str = "<bold>\(amount.ft_cleanString)</bold> <normal>\(value)</normal>"
        return str.set(style: group)
    }
}
