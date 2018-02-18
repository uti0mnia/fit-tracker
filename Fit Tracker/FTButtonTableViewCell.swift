//
//  FTButtonTableViewCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-18.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTButtonTableViewCell: UITableViewCell {
    
    public let button = FTButtonFactory.simpleButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(button)
        button.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalToSuperview().inset(Layout.defaultInsets)
        }
    }
    
}
