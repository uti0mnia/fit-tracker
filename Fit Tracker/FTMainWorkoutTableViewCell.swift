//
//  FTMainWorkoutCollectionViewCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-14.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTMainWorkoutCollectionViewCellDelegate: class {
    func mainWokroutCollectionViewCellDidTapStart(_ cell: FTMainWorkoutTableViewCell, forWorkout: FTWorkoutTemplate)
    func mainWokroutCollectionViewCellDidTapEdit(_ cell: FTMainWorkoutTableViewCell, forWorkout: FTWorkoutTemplate)
}

class FTMainWorkoutTableViewCell: UITableViewCell {
    
    public weak var delegate: FTMainWorkoutCollectionViewCellDelegate?
    
    public let nameLabel = FTTitleLabel()
    public let descriptionLabel = FTDescriptionLabel()
    public let startButton = FTButtonFactory.strongButton()
    public let editButton = FTButtonFactory.countourButton()
    
    public var workout: FTWorkoutTemplate? {
        didSet {
            guard let workout = workout else {
                return
            }
            
            nameLabel.text = workout.name
            // The flat map grabs the name of the exercise associated with the exercise template if the elements are of type FTExerciseTemplate
            descriptionLabel.text = workout.groupTemplates?.flatMap() { (group: FTExerciseGroupTemplate) in
                group.exerciseTemplates?.flatMap() { (log: FTExerciseTemplate) in
                    return log.exercise?.name
                }.joined(separator: " • ")
            }.joined(separator: " • ")
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVisuals()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVisuals() {
        startButton.setTitle("FTMainWorkoutCollectionViewCell_Start".ft_localized, for: .normal)
        startButton.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
        
        editButton.setTitle("FTMainWorkoutCollectionViewCell_Edit".ft_localized, for: .normal)
        editButton.addTarget(self, action: #selector(didTapEditButton(_:)), for: .touchUpInside)
        
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(startButton)
        contentView.addSubview(editButton)
        
        nameLabel.snp.makeConstraints() { make in
            make.left.top.right.equalToSuperview().inset(FTLayout.largeInsets)
        }
        descriptionLabel.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(FTLayout.largeInsets)
            make.top.equalTo(nameLabel.snp.bottom).offset(FTLayout.defaultPadding)
        }
        startButton.snp.makeConstraints() { make in
            make.right.bottom.equalToSuperview().inset(FTLayout.largeInsets)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(FTLayout.defaultPadding)
            make.left.equalTo(editButton.snp.right).offset(FTLayout.largePadding)
        }
        editButton.snp.makeConstraints() { make in
            make.left.bottom.equalToSuperview().inset(FTLayout.largeInsets)
            make.top.equalTo(startButton)
            make.width.equalTo(startButton.snp.width)
        }
    }
    
    
    @objc private func didTapStartButton(_ sender: UIButton) {
        guard let workout = workout else {
            return
        }
        delegate?.mainWokroutCollectionViewCellDidTapStart(self, forWorkout: workout)
    }
    
    @objc private func didTapEditButton(_ sender: UIButton) {
        guard let workout = workout else {
            return
        }
        delegate?.mainWokroutCollectionViewCellDidTapEdit(self, forWorkout: workout)
    }
    
}
