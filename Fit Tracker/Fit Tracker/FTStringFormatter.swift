//
//  FTStringFormatter.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation

class FTStringFormatter: NSObject {
    
    public static let shared = FTStringFormatter()
    
    override private init() {}
    
    public func formatAsMinutes(seconds: Int) -> String {
        let m = seconds % 59
        let s = seconds - seconds * m
        return String(format: "%i:%02d", m, s)
    }
    
}
