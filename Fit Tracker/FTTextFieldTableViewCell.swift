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
    
    public let defaultPlaceholderColour: UIColor
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        defaultPlaceholderColour = textField.placeholderColour
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVisuals()
    }
    
    required init?(coder aDecoder: NSCoder) {
        defaultPlaceholderColour = textField.placeholderColour
        
        super.init(coder: aDecoder)
        
        setupVisuals()
    }
    
    private func setupVisuals() {
        contentView.addSubview(textField)
        textField.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(FTLayout.defaultInsets)
            make.top.bottom.equalToSuperview().inset(FTLayout.largeInsets)
        }
    }

}
