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
        textField.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(FTLayout.defaultInsets)
            make.top.bottom.equalToSuperview().inset(FTLayout.largeInsets)
        }
    }

}
