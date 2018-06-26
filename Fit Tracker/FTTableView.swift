//
//  FTTableView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-23.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        alwaysBounceVertical = true
        contentInset = UIEdgeInsets(top: 0, left: FTLayout.smallPadding, bottom: 0, right: -FTLayout.smallPadding)
        backgroundColor = FTColours.background
    }
    
    
}
