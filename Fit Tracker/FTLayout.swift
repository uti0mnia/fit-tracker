//
//  FTLayout.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-08.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit

class FTLayout: NSObject {
    
    private override init() {}
    
    // TabBar.
    public static let tabBarHeight: CGFloat = 50
    
    // Padding.
    public static let defaultPadding: CGFloat = 8
    public static let largePadding: CGFloat = 16
    public static let bigPadding: CGFloat = 30
    
    // Insets.
    public static let defaultInsets = UIEdgeInsets(top: FTLayout.defaultPadding,
                                                   left: FTLayout.defaultPadding,
                                                   bottom: FTLayout.defaultPadding,
                                                   right: FTLayout.defaultPadding)
    public static let largeInsets = UIEdgeInsets(top: FTLayout.largePadding,
                                                 left: FTLayout.largePadding,
                                                 bottom: FTLayout.largePadding,
                                                 right: FTLayout.largePadding)
    
    // Buttons.
    public static let buttonCornerRadius: CGFloat = 4
    public static let buttonShadowOffset = CGSize(width: 0.5, height: 0.5)
    public static let defaultButtonHeight: CGFloat = 44
    public static let smallButtonHeight: CGFloat = 30
    public static let contourButtonBorderWidth: CGFloat = 1.5
    
    // Specific
    public static let setMultiplySize: CGFloat = 12
    
}
