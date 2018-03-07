//
//  FTEditWorkoutCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-05.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTEditWorkoutCell: UITableViewCell {
    
    private let nameLabel = FTSizedLabel()
    private let setLabel = FTSizedLabel(textSize: .medium)
    
    public var exerciseTemplate: FTExerciseTemplate? {
        didSet {
            nameLabel.text = exerciseTemplate?.exercise?.name
            setLabel.text = "\(exerciseTemplate?.setTemplates?.count ?? 0) Sets"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(setLabel)
        
        nameLabel.snp.makeConstraints() { make in
            make.left.top.right.equalToSuperview().inset(FTLayout.defaultInsets)
        }
        
        setLabel.snp.makeConstraints() { make in
            make.left.bottom.right.equalToSuperview().inset(FTLayout.defaultInsets)
            make.top.equalTo(nameLabel.snp.bottom).offset(FTLayout.defaultPadding)
        }
        
        accessoryType = .disclosureIndicator
    }
    
}
