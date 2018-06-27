//
//  FTDoubleExtension.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-19.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation

extension Double {
    // This returns a string with no decimals if the value is an int, if not it returns one decimal point.
    // Useful for 225 lbs vs 27.5 lbs.
    public var ft_cleanString: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
