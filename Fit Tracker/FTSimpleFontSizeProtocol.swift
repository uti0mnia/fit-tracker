//
//  FTSimpleFontSize.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

public enum SimpleFontSize {
    case micro, tiny, small, medium, large
    
    public var font: UIFont {
        switch self {
        case .micro:
            return FTFonts.micro
        case .tiny:
            return FTFonts.tiny
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
