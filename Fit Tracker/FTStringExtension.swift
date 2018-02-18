//
//  StringExtension.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-14.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation

extension String {
    var ft_localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
