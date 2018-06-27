//
//  FTFontsExtension.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-27.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import SwiftRichString

extension UIFont {
    public func ft_toFontAttribute() -> FontAttribute {
        if let final = FontAttribute(font: self) {
            return final
        }
        return FontAttribute(font: SRFont.systemFont(ofSize: self.pointSize))!
    }
}
