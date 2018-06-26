//
//  FTWorkoutInfoBar.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-24.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTWorkoutInfoBarDelegate: class {
    func workoutInfoBar(_ workoutInfoBar: FTWorkoutInfoBar, didTapButtonWithType type: FTWorkoutInfoBar.ButtonType)
}

class FTWorkoutInfoBar: UIView {
    
    @IBOutlet private weak var notesButton: UIButton! // tag = 0
    @IBOutlet private weak var plateCalculatorButton: UIButton! // tag = 1
    @IBOutlet private weak var warmupButton: UIButton! // tag = 2
    @IBOutlet private weak var timerButton: UIButton! // tag = 3
    @IBOutlet private weak var moreButton: UIButton! // tag = 4
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    public weak var delegate: FTWorkoutInfoBarDelegate?
    
    public enum ButtonType {
        case notes, caculatePlates, warmup, timer, more
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonCollection.forEach({
            $0.imageView?.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = FTLayout.infoBarCornerRadius
            $0.layer.shadowColor = FTColours.infoBarShadow.cgColor
            $0.layer.shadowRadius = FTLayout.infoBarShadowRadius
            $0.layer.shadowOpacity = FTColours.infoBarShadowOpacity
        })
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
    

}
