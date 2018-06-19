//
//  FTRoundPixel.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-18.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import UIKit

public func roundToPixel(_ p: CGFloat) -> CGFloat {
    return round(p * UIScreen.main.scale) / UIScreen.main.scale
}

public func ceilToPixel(_ p: CGFloat) -> CGFloat {
    return ceil(p * UIScreen.main.scale) / UIScreen.main.scale
}

public func floorToPixel(_ p: CGFloat) -> CGFloat {
    return floor(p * UIScreen.main.scale) / UIScreen.main.scale
}
