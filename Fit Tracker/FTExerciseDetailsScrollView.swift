//
//  FTExerciseDetailsScrollView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-25.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTExerciseDetailsScrollView: UIScrollView {

    private let container = UIView()
    
    public let nameLabel = FTSizedLabel()
    public let textField = FTDefaultTextField()
    
    public let noteLabel = FTSizedLabel()
    public let textView = FTTextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        
        container.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
            make.centerX.equalToSuperview()
        }
        container.isUserInteractionEnabled = true
        
        container.addSubview(nameLabel)
        container.addSubview(textField)
        container.addSubview(noteLabel)
        container.addSubview(textView)
        
        nameLabel.snp.makeConstraints() { make in
            make.top.right.left.equalToSuperview().inset(FTLayout.defaultInsets)
        }
        
        textField.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(FTLayout.defaultPadding)
        }
        textField.returnKeyType = .done
        
        noteLabel.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(FTLayout.defaultInsets)
            make.top.equalTo(textField.snp.bottom).offset(FTLayout.defaultPadding)
        }
        
        textView.snp.makeConstraints() { make in
            make.top.equalTo(noteLabel.snp.bottom).offset(FTLayout.defaultPadding)
            make.left.right.equalToSuperview()
            make.height.equalTo(132)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
