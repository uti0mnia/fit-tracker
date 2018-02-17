//
//  FTDefaultTextField.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTDefaultTextField: UITextField, FTSimpleFontSize {

    public var textSize: SimpleFontSize = .large {
        didSet {
            self.font = textSize.font
        }
    }
    
    public var placeholderColour = Colours.grayTextColour {
        didSet {
            updatePlaceholder()
        }
    }
    
    override var placeholder: String? {
        didSet {
            updatePlaceholder()
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
        self.textColor = Colours.darkTextColour
        self.borderStyle = .none
        self.clearButtonMode = .always
    }
    
    private func updatePlaceholder() {
        guard let placeholder = self.placeholder else {
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColour])
    }
}
