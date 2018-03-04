//
//  FTArrayExtension.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-25.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation

extension Array {
    public func ft_safeAccess(at idx: Int) -> Element? {
        guard idx >= 0, idx < count else {
            return nil
        }
        return self[idx]
    }
    
}
