//
//  FTSimpleFontSize.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

public enum SimpleFontSize {
    case small, medium, large
    
    public var font: UIFont {
        switch self {
        case .small:
            return FTFonts.small
        case .medium:
            return FTFonts.medium
        case .large:
            return FTFonts.large
        }
    }
}

protocol FTSimpleFontSize: class {
    var textSize: SimpleFontSize { get set }
}
