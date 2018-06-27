//
//  FTTimerBar.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-26.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@IBDesignable
class FTTimerBar: UIView {
    
    private var timerBar = UIView()
    private var label = UILabel()
    
    public var maxTime: Int = 60 {
        didSet {
            timerBar.frame = bounds
            label.text = FTStringFormatter.shared.formatAsMinutes(seconds: maxTime)
        }
    }
    public var currentTime: Int = 60 {
        didSet {
            var p = CGFloat(currentTime / maxTime)
            if p < 0 { p = 0 }
            else if p > 1 { p = 1 }
            timerBar.frame = CGRect(x: 0, y: 0, width: roundToPixel(self.bounds.width * p), height: frame.height)
            label.text = FTStringFormatter.shared.formatAsMinutes(seconds: currentTime)
        }
    }
    
    @IBInspectable public var enabled: Bool = true {
        didSet {
            timerBar.isHidden = !enabled
            label.isHidden = !enabled
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = FTColours.timerBarBackground
        
        addSubview(timerBar)
        timerBar.frame = bounds
        timerBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        timerBar.backgroundColor = FTColours.blue
        
        addSubview(label)
        label.font = FTFonts.tiny
        label.textAlignment = .center
        label.snp.makeConstraints() { make in
            make.center.equalToSuperview()
        }
        label.text = FTStringFormatter.shared.formatAsMinutes(seconds: currentTime)
    }

}
