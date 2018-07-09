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
    
    // Cells
    public static let defaultCellHeight: CGFloat = 48
    public static let emptyWorkoutCellHeight: CGFloat = 135
    
    // Info bar
    public static let infoBarCornerRadius: CGFloat = 2
    public static let infoBarShadowRadius: CGFloat = 1
    public static let infoBarItemIconSize: CGFloat = 27
    public static let infoBarItemHeight: CGFloat = 38
    
    // Timer bar
    public static let timerBarHeight: CGFloat = 14
    
    // Exercise Set
    public static let workoutSetCellHeight: CGFloat = 45
    
    // Buttons.
    public static let buttonSmall: CGFloat = 26
    public static let buttonRegular: CGFloat = 32
    public static let buttonLarge: CGFloat = 44
    public static let buttonShadowRadius: CGFloat = 2
    public static let minButtonTap: CGFloat = 44
    
    public static let bottomButtonCornerRadius: CGFloat = 8
    
    // Specific
    public static let setMultiplySize: CGFloat = 12
    public static let defaultTableViewCellHeight: CGFloat = 50
    
    // Misc
    public static let lineHeight: CGFloat = 2
    public static let lineCornerRadius: CGFloat = 1
    public static let smallIconSize: CGFloat = 20
    public static let mediumIconSize: CGFloat = 26
    
}
