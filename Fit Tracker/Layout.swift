//
//  Layout.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-08.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit

class Layout: NSObject {
    
    private override init() {}
    
    // TabBar.
    public static let tabBarHeight: CGFloat = 50
    
    // Padding.
    public static let defaultPadding: CGFloat = 8
    public static let largePadding: CGFloat = 16
    
    // Insets.
    public static let defaultInsets = UIEdgeInsets(top: Layout.defaultPadding,
                                                   left: Layout.defaultPadding,
                                                   bottom: Layout.defaultPadding,
                                                   right: Layout.defaultPadding)
    public static let largeInsets = UIEdgeInsets(top: Layout.largePadding,
                                                 left: Layout.largePadding,
                                                 bottom: Layout.largePadding,
                                                 right: Layout.largePadding)
    
    // Buttons.
    public static let buttonCornerRadius: CGFloat = 4
    public static let buttonShadowOffset = CGSize(width: 0.5, height: 0.5)
    public static let simpleButtonHeight: CGFloat = 44
    
}
