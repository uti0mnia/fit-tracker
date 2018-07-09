//
//  FTSegmentItem.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-27.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@IBDesignable
public class FTSegmentItem: UIView {
    
    @IBInspectable public let label = UILabel()
    private let line = UIView()
    
    public var isSelected = true {
        didSet {
            line.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        label.textAlignment = .center
        label.font = FTFonts.body
        addSubview(label)
        
        line.layer.cornerRadius = FTLayout.lineCornerRadius
        line.backgroundColor = FTColours.blue
        addSubview(line)
        line.snp.makeConstraints() { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(FTLayout.lineHeight)
        }
    }
    
}
