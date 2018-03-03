//
//  FTExerciseSelectionCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTExerciseSelectionCell: UITableViewCell {
    
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
        
        mainLabel.snp.makeConstraints() { make in
            make.left.top.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
        }
        mainLabel.textSize = .large
        
        detailLabel.snp.makeConstraints() { make in
            make.top.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
            make.right.equalTo(accessoryView?.snp.left ?? contentView.snp.right).inset(FTLayout.defaultInsets)
            make.left.greaterThanOrEqualTo(mainLabel.snp.right).offset(FTLayout.defaultPadding)
        }
        detailLabel.textColor = FTColours.grayTextColour
        detailLabel.textAlignment = .right
        detailLabel.textSize = .large
    }
    
}
