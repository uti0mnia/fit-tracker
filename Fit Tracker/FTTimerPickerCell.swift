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
    
    private var minutes: [Int] = {
        var minutes = [Int]()
        for i in 0..<10 {
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
    
    private let pickerView = UIPickerView()
    
    public let mainLabel = FTSizedLabel()
    private let detailLabel = FTSizedLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        setupVisuals()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupVisuals() {
        let labelStackView = UIStackView(arrangedSubviews: [mainLabel, detailLabel])
        
        mainLabel.textSize = .large
        mainLabel.text = "FTTimerPickerCell_RestTimer".ft_localized
        
        detailLabel.textColor = FTColours.grayTextColour
        detailLabel.textAlignment = .right
        detailLabel.textSize = .large
        detailLabel.text = FTStringFormatter.shared.formatAsMinutes(seconds: FTSettingsManager.shared.preferredRestTime)
        
        let stackView = UIStackView(arrangedSubviews: [labelStackView, pickerView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = FTLayout.defaultPadding
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints({ $0.left.top.right.bottom.equalToSuperview().inset(FTLayout.defaultPadding) })
    }
    
    public func togglePickerView() {
        pickerView.isHidden = !pickerView.isHidden
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
        detailLabel.text = FTStringFormatter.shared.formatAsMinutes(seconds: time)
        delegate?.timerPickerCell(self, didUpdateTimerValueTo: time)
    }
}
