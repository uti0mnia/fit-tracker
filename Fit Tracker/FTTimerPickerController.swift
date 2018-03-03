//
//  FTTimerPickerView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-03.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTTimerPickerControllerDelegate: class {
    func timerPickerController(_ controller: FTTimerPickerController, didUpdateTimeTo time: Int)
}

class FTTimerPickerController: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public weak var delegate: FTTimerPickerControllerDelegate?
    
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
    
    public let pickerView = UIPickerView()
    
    override init() {
        super.init()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }

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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let minutes = self.minutes[pickerView.selectedRow(inComponent: 0)]
        let seconds = self.seconds[pickerView.selectedRow(inComponent: 1)]
        delegate?.timerPickerController(self, didUpdateTimeTo: minutes * 60 + seconds)
    }

}
