//
//  FTTimerPickerCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-03.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import SnapKit

protocol FTTimerPickerCellDelegate: class {
    func timerPickerCell(_ cell: FTTimerPickerCell, didUpdateTimerValueTo value: Int)
}

class FTTimerPickerCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public weak var delegate: FTTimerPickerCellDelegate?
    
    @IBOutlet private weak var pickerView: UIPickerView!
    
    
    private var minutes: [Int] = {
        var minutes = [Int]()
        for i in 0..<10 {
            minutes.append(i) // indexing is n to n
        }
        return minutes
    }()
    
    private var seconds: [Int] = {
        var seconds = [Int]()
        for i in 0..<12 {
            seconds.append(i * 5) // indexing is n to 5n
        }
        return seconds
    }()
    
    public func setPickerTimer(seconds: Int, animated: Bool) {
        var minutes = Int(seconds/60)
        var seconds = Int(round(Double((seconds - minutes * 60) / 5)) * 5)
        if minutes > 9 {
            minutes = 9
            seconds = 55
        }
        pickerView.selectRow(minutes, inComponent: 0, animated: animated)
        pickerView.selectRow(seconds/5, inComponent: 1, animated: animated)
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? minutes.count : seconds.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? "\(minutes[row]) m" : "\(seconds[row]) s"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let minutes = self.minutes[pickerView.selectedRow(inComponent: 0)]
        let seconds = self.seconds[pickerView.selectedRow(inComponent: 1)]
        let time = minutes * 60 + seconds
        delegate?.timerPickerCell(self, didUpdateTimerValueTo: time)
    }
}
