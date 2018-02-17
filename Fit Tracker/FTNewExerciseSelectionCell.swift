//
//  FTNewExerciseSelectionCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTNewExerciseSelectionCell: UITableViewCell {
    
    public let mainLabel = FTSizedLabel()
    public let detailLabel = FTSizedLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVisuals()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVisuals() {
        contentView.addSubview(mainLabel)
        contentView.addSubview(detailLabel)
        
        accessoryType = .disclosureIndicator
        
        mainLabel.snp.makeConstraints() { make in
            make.left.top.bottom.equalToSuperview().inset(Layout.defaultInsets)
        }
        mainLabel.textSize = .large
        
        detailLabel.snp.makeConstraints() { make in
            make.top.bottom.equalToSuperview().inset(Layout.defaultInsets)
            make.right.equalTo(accessoryView?.snp.left ?? contentView.snp.right).inset(Layout.defaultInsets)
            make.left.greaterThanOrEqualTo(mainLabel.snp.right).offset(Layout.defaultPadding)
        }
        detailLabel.textColor = Colours.grayTextColour
        detailLabel.textAlignment = .right
        detailLabel.textSize = .large
    }
    
}
