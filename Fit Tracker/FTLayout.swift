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
    public static let smallPadding: CGFloat = 6
    public static let mediumPadding: CGFloat = 10
    public static let largePadding: CGFloat = 16
    
    // Insets.
    public static let defaultInsets = UIEdgeInsets(top: FTLayout.mediumPadding,
                                                   left: FTLayout.mediumPadding,
                                                   bottom: FTLayout.mediumPadding,
                                                   right: FTLayout.mediumPadding)
    public static let largeInsets = UIEdgeInsets(top: FTLayout.largePadding,
                                                 left: FTLayout.largePadding,
                                                 bottom: FTLayout.largePadding,
                                                 right: FTLayout.largePadding)
    
    // Buttons.
    public static let buttonSmall: CGFloat = 26
    public static let buttonRegular: CGFloat = 32
    public static let buttonLarge: CGFloat = 44
    public static let minButtonTap: CGFloat = 44
    
    public static let buttonCornerRadius: CGFloat = 4
    public static let buttonShadowOffset = CGSize(width: 0.5, height: 0.5)
    public static let tallButtonHeight: CGFloat = 56
    public static let defaultButtonHeight: CGFloat = 44
    public static let smallButtonHeight: CGFloat = 30
    public static let contourButtonBorderWidth: CGFloat = 1.5
    
    // Specific
    public static let setMultiplySize: CGFloat = 12
    public static let defaultTableViewCellHeight: CGFloat = 50
    
}
