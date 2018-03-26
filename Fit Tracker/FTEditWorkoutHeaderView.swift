//
//  FTEditWorkoutHeaderView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-25.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEditWorkoutHeaderView: UIView {
    
    public var titleLabel = FTSizedLabel()
    public var addButton = UIButton(type: .contactAdd)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(addButton)
        
        backgroundColor = FTColours.lightForeground
        
        titleLabel.snp.makeConstraints() { make in
            make.left.top.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
            make.right.lessThanOrEqualTo(addButton.snp.left)
        }
        
        addButton.snp.makeConstraints() { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FTLayout.defaultInsets)
        }
        addButton.tintColor = FTColours.mainPrimary
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
