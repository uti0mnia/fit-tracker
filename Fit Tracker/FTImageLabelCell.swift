//
//  FTImageLabelCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-27.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTImageLabelCell: UITableViewCell {
    
    public let icon = UIImageView()
    public let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        let view = UIView()
        view.addSubview(icon)
        view.addSubview(label)
        
        icon.snp.makeConstraints() { make in
            make.height.width.equalTo(FTLayout.mediumIconSize)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints() { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalTo(icon.snp.right)
        }
        
        contentView.addSubview(view)
        view.snp.makeConstraints() { make in
            make.center.equalToSuperview()
        }
        
        selectionStyle = .none
    }
    
}
