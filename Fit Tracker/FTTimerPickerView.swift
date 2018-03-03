//
//  FTTimerPickerView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-03.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTTimerPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var minutes: [Int] = {
        var minutes = [Int]()
        for i in 0..<60 {
            minutes.append(i)
        }
        return minutes
    }()
    
    private var seconds: [Int] = {
        var seconds = [Int]()
        for i in 0..<12 {
            seconds.append(i * 5)
        }
        return seconds
    }()

    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? seconds.count : minutes.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? "\(seconds[row]) s" : "\(minutes[row]) m"
    }

}
