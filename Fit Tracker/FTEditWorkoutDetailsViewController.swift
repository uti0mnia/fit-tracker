//
//  FTEditWorkoutDetailsViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-03-25.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData
import SnapKit

class FTEditWorkoutDetailsViewController: UIViewController {
    
    private let workout: FTWorkoutTemplate
    private let context: NSManagedObjectContext
    
    private let detailScrollView = FTExerciseDetailsScrollView()

    required init(workout: FTWorkoutTemplate, context: NSManagedObjectContext) {
        self.workout = workout
        self.context = context
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Workout Details"
        navigationController?.navigationBar.tintColor = FTColours.mainPrimary

        view.addSubview(detailScrollView)
        
        view.backgroundColor = FTColours.lightBackground
        
        detailScrollView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        detailScrollView.alwaysBounceVertical = true
        detailScrollView.showsVerticalScrollIndicator = false
        detailScrollView.keyboardDismissMode = .onDrag
        detailScrollView.contentInset = UIEdgeInsets(top: FTLayout.defaultPadding, left: 0, bottom: FTLayout.defaultPadding, right: 0)
        detailScrollView.nameLabel.text = "Workout name"
        detailScrollView.noteLabel.text = "Workout notes"
    }
}
