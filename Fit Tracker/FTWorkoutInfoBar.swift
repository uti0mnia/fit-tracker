//
//  FTWorkoutInfoBar.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-24.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@objc protocol FTWorkoutInfoBarDelegate: class {
    func workoutInfoBar(_ workoutInfoBar: FTWorkoutInfoBar, didTapButtonWithType type: FTWorkoutInfoBar.ButtonType)
}

class FTWorkoutInfoBar: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet public weak var delegate: FTWorkoutInfoBarDelegate?
    
    @objc public enum ButtonType: Int {
        case notes, caculatePlates, warmup, timer, more
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
        Bundle.main.loadNibNamed("FTWorkoutInfoBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction private func handleButtonTap(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            delegate?.workoutInfoBar(self, didTapButtonWithType: .notes)
        case 1:
            delegate?.workoutInfoBar(self, didTapButtonWithType: .caculatePlates)
        case 2:
            delegate?.workoutInfoBar(self, didTapButtonWithType: .warmup)
        case 3:
            delegate?.workoutInfoBar(self, didTapButtonWithType: .timer)
        case 4:
            delegate?.workoutInfoBar(self, didTapButtonWithType: .more)
        default:
            break
        }
    }
    
    public func disableAll() {
        buttonCollection.forEach({ $0.isEnabled = false })
    }
    
    public func enableAll() {
        buttonCollection.forEach({ $0.isEnabled = true })
    }

}
