//
//  FTEmptyWorkoutCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-24.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEmptyWorkoutCell: UITableViewCell {
    
    private lazy var emptyView: FTEmptyWorkoutView = { [unowned self] in
        let view = FTEmptyWorkoutView.instantiateFromNib()
        view.frame = self.contentView.frame
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.mainLabel.text = "You have no workouts."
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(emptyView)
    }
    
}
