//
//  FTExerciseSetView.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-27.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

@objc protocol FTExerciseSetViewDelegate: class {
    func exerciseSetViewDidSelectWorkoutTab(_ exerciseSetView: FTExerciseSetView)
    func exerciseSetViewDidSelectPreviousTab(_ exerciseSetView: FTExerciseSetView)
}

@IBDesignable
class FTExerciseSetView: UIView, FTSegmentControlViewDelegate {
    
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet private weak var segmentController: FTSegmentControlView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBInspectable public weak var delegate: FTExerciseSetViewDelegate?

    private var selectedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FTExerciseSetView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = FTColours.background
        
        exerciseLabel.font = FTFonts.headline
        
        segmentController.delegate = self
        segmentController.segmentCount = 2
        segmentController.selectedIndex = selectedIndex
        let items = segmentController.items
        items[0].label.text = "Workout"
        items[1].label.text = "Previous"
    }
    
    // MARK: - FTSegmentControlViewDelegate
    
    func segmentControlView(_ segmentControlView: FTSegmentControlView, didSelectIndex index: Int) {
        guard index != selectedIndex else {
            return
        }
        
        selectedIndex = index
        if index == 0 {
            delegate?.exerciseSetViewDidSelectWorkoutTab(self)
        } else {
            delegate?.exerciseSetViewDidSelectPreviousTab(self)
        }
    }
}
