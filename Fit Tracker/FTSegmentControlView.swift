//
//  FTSegmentControlView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-27.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@objc protocol FTSegmentControlViewDelegate: class {
    func segmentControlView(_ segmentControlView: FTSegmentControlView, didSelectIndex index: Int)
}

@IBDesignable
class FTSegmentControlView: UIView {
    
    @IBInspectable public var segmentCount = 2 {
        didSet {
            var diff = stackView.arrangedSubviews.count - segmentCount
            while diff != 0 {
                if diff < 0 {
                    stackView.addArrangedSubview(FTSegmentItem())
                    diff += 1
                } else {
                    stackView.arrangedSubviews.last?.removeFromSuperview()
                    diff -= 1
                }
            }
        }
    }
    @IBInspectable public var selectedIndex = 0 {
        didSet {
            guard selectedIndex < stackView.arrangedSubviews.count else {
                return
            }
            
            for i in 0...stackView.arrangedSubviews.count {
                if let item = stackView.arrangedSubviews[i] as? FTSegmentItem {
                    item.isSelected = i == selectedIndex
                }
            }
        }
    }
    @IBInspectable public weak var delegate: FTSegmentControlViewDelegate?
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(stackView)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
