//
//  FTPreviewWorkoutExerciseCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 4/22/18.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTPreviewWorkoutExerciseCell: UITableViewCell {
    
    private let nib = UINib(nibName: "FTPreviewWorkoutExerciseView", bundle: nil)
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = FTLayout.mediumPadding
        return stackView
    }()
    
    public var groupTemplate: FTExerciseGroupTemplate? {
        didSet {
            if oldValue == groupTemplate {
                return
            }
            
            stackView.subviews.forEach( { $0.removeFromSuperview() })
            
            guard let exercises = groupTemplate?.exerciseTemplates else {
                return
            }
            
            for exercise in exercises {
                guard let view = nib.instantiate(withOwner: nil, options: nil).first as? FTPreviewWorkoutExerciseView else {
                    assertionFailure("Nib incorrectly configured")
                    return
                }
                
                assert(exercise.exercise != nil, "Exercise templates needs FTExercise")
                assert(exercise.setTemplates != nil, "Exercise templates needs FTSetTemplates")
                
                view.nameLabel.text = exercise.exercise?.name
                view.detailLabel.text = exercise.exercise?.getCategory().description
                view.numberOfSets = exercise.setTemplates?.count ?? 0
                
                stackView.addArrangedSubview(view)
            }
            
            setNeedsUpdateConstraints()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints() { make in
            make.left.top.right.bottom.equalToSuperview().inset(FTLayout.defaultInsets)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
