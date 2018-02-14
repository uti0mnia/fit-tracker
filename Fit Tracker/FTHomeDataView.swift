//
//  FTHomeMainItemView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-12.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import SnapKit

class FTHomeDataView: UIView {
    
    public let mainLabel = FTTitleLabel()
    public let graphView = UIView() // TODO: Change to some special data view thing.
    public let subLabel = FTBodyLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = Colours.lightPrimary
        
        addSubview(mainLabel)
        addSubview(subLabel)

        mainLabel.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(Layout.defaultPadding)
            make.top.equalToSuperview()
        }

        subLabel.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(Layout.defaultPadding)
            make.bottom.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(Layout.defaultPadding)
        }
    }
    
}
