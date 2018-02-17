//
//  FTTextFieldTableViewCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTTextFieldTableViewCell: UITableViewCell {
    
    public let textField = FTDefaultTextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVisuals()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupVisuals()
    }
    
    private func setupVisuals() {
        contentView.addSubview(textField)
        textField.frame = contentView.bounds.insetBy(dx: Layout.defaultPadding * 2, dy: Layout.defaultPadding * 2)
        textField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
