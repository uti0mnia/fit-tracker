//
//  FTEditWorkoutSetTableViewCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-18.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTEditWorkoutSetTableViewCellDelegate: class {
    func editWorkoutSetTableViewCell(_ cell: FTEditWorkoutSetTableViewCell, didTapRemoveForSet: FTSetTemplate)
//    func editWorkoutSetTableViewCell(_ cell: FTEditWorkoutSetTableViewCell, didSwipeToDeleteSet: FTSetTemplate)
}

class FTEditWorkoutSetTableViewCell: UITableViewCell {
    
    private let removeButton = FTButtonFactory.destructiveButton(cornerRadius: 2)
    private let weightLabel = FTSizedLabel()
    private let weightDescriptionLabel = FTSizedLabel(textSize: .medium)
    private let multiplyView = UIImageView(image: #imageLiteral(resourceName: "multiply"))
    private let repsLabel = FTSizedLabel()
    private let repsDescriptionLabel = FTSizedLabel(textSize: .medium)
    
    public weak var delegate: FTEditWorkoutSetTableViewCellDelegate?
    
    public var setTemplate: FTSetTemplate? {
        didSet {
            guard let setTemplate = setTemplate else {
                return
            }
            
            weightLabel.text = "\(setTemplate.weight.cleanString)"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVisuals()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVisuals() {
        // Subview adding.
        contentView.addSubview(removeButton)
        contentView.addSubview(weightLabel)
        contentView.addSubview(weightDescriptionLabel)
        contentView.addSubview(multiplyView)
        contentView.addSubview(repsLabel)
        contentView.addSubview(repsDescriptionLabel)
        
        // Constraints.
        removeButton.snp.makeConstraints() { make in
            make.left.top.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
            make.width.equalTo(removeButton.snp.height)
        }
        weightLabel.snp.makeConstraints() { make in
            make.top.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
            make.left.equalTo(removeButton.snp.right).offset(FTLayout.defaultPadding)
        }
        weightDescriptionLabel.snp.makeConstraints() { make in
            make.top.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
            make.left.equalTo(weightLabel.snp.right).offset(FTLayout.defaultPadding)
        }
        multiplyView.snp.makeConstraints() { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(FTLayout.setMultiplySize)
            make.left.equalTo(weightDescriptionLabel.snp.right).offset(FTLayout.defaultPadding)
        }
        repsLabel.snp.makeConstraints() { make in
            make.left.equalTo(multiplyView.snp.right).offset(FTLayout.defaultPadding)
            make.top.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
        }
        repsDescriptionLabel.snp.makeConstraints() { make in
            make.left.equalTo(repsLabel.snp.right).offset(FTLayout.defaultPadding)
            make.top.right.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
        }
        
        // Visuals.
        multiplyView.contentMode = .center
        
        removeButton.setTitle("-", for: .normal)
        removeButton.titleLabel?.textAlignment = .center
        
        weightLabel.textAlignment = .right
        repsLabel.textAlignment = .right
        
        weightDescriptionLabel.font = FTFonts.setDescription
        weightDescriptionLabel.text = FTSettingsManager.shared.preferredWeight.string
        
        repsDescriptionLabel.font = FTFonts.setDescription
        repsDescriptionLabel.text = "FTGeneral_Reps".ft_localized
        
        // Other
        removeButton.addTarget(self, action: #selector(didTapRemoveButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapRemoveButton(_ sender: UIButton) {
        guard let set = setTemplate else {
            return
        }
        
        self.delegate?.editWorkoutSetTableViewCell(self, didTapRemoveForSet: set)
    }
    
}
