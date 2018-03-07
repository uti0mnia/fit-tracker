//
//  FTIntrinsicTableView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-06.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTIntrinsicTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }
    
}
