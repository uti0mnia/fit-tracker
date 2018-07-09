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
            
            if selectedIndex > segmentCount {
                selectedIndex = 0
            }
            updateTags()
        }
    }
    @IBInspectable public var selectedIndex = 0 {
        didSet {
            updateSelected()
        }
    }
    @IBInspectable public weak var delegate: FTSegmentControlViewDelegate?
    
    public var items: [FTSegmentItem] {
        return stackView.arrangedSubviews.compactMap() { return $0 as? FTSegmentItem }
    }
    
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
    
    @objc private func handleSegmentTap(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        if view.tag != selectedIndex {
            selectedIndex = view.tag
        }
        updateSelected()
        delegate?.segmentControlView(self, didSelectIndex: view.tag)
    }
    
    private func commonInit() {
        addSubview(stackView)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func updateSelected() {
        guard selectedIndex < stackView.arrangedSubviews.count else {
            return
        }
        
        for i in 0..<stackView.arrangedSubviews.count {
            if let view = stackView.arrangedSubviews[i] as? FTSegmentItem {
                view.isSelected = i == selectedIndex
            }
        }
    }
    
    private func updateTags() {
        for i in 0..<stackView.arrangedSubviews.count {
            let view = stackView.arrangedSubviews[i]
            view.tag = i
            view.gestureRecognizers?.removeAll()
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleSegmentTap(_:)))
            view.addGestureRecognizer(tap)
        }
    }
    
}
