//
//  FTNewExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTNewExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FTTimerPickerCellDelegate {
    
    private let detailVC = FTNewExerciseDetailViewController()
    
    // Refactor to be lazy init so they're not optional.
    private var saveButton: UIBarButtonItem?
    private var dismissButton: UIBarButtonItem?
    
    // Cells - normally we wouldn't do this but fuck it there's like 5 and it's static.
    private var exerciseNameCell = FTTextFieldTableViewCell()
    // Do it this way because I fucking used xib kill me.
    private var bodyPartCell = Bundle.main.loadNibNamed("FTExerciseSelectionCell", owner: nil, options: nil)?.first as! FTExerciseSelectionCell
    private var categoryCell = Bundle.main.loadNibNamed("FTExerciseSelectionCell", owner: nil, options: nil)?.first as! FTExerciseSelectionCell
    private var timerCell = Bundle.main.loadNibNamed("FTExerciseSelectionCell", owner: nil, options: nil)?.first as! FTExerciseSelectionCell
    private var pickerCell = Bundle.main.loadNibNamed("FTTimerPickerCell", owner: nil, options: nil)?.first as! FTTimerPickerCell
    
    private lazy var cellMap: [IndexPath: UITableViewCell] = {
        return [
            IndexPath(row: 0, section: 0): exerciseNameCell,
            IndexPath(row: 0, section: 1): bodyPartCell,
            IndexPath(row: 1, section: 1): categoryCell,
            IndexPath(row: 0, section: 2): timerCell,
            IndexPath(row: 1, section: 2): pickerCell
        ]
    }()
    private var sections: [Int: Int] {
        return [
            0: 1,
            1: 2,
            2: isPickerCellHidden ? 1 : 2
        ]
    }
    private var isPickerCellHidden = true
    private let pickerCellIndex = IndexPath(row: 1, section: 2)

    private var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.rowHeight = UITableViewAutomaticDimension
        return tv
    }()
    private var exercise: FTExercise!
    private var context = FTDataController.shared.createBackgroundContext()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        
        exercise = FTExercise(context: self.context)
        exercise.createdAt = NSDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        setupVisuals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChangeNotification(_:)), name: .UITextFieldTextDidChange, object: nil)
        
        updateBodyPartCell()
        updateCategoryCell()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupVisuals() {
        title = "FTNewExerciseViewController_Title".ft_localized
        view.backgroundColor = FTColours.lightBackground
        
        navigationController?.navigationBar.tintColor = FTColours.mainPrimary
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveButton(_:)))
        navigationItem.rightBarButtonItem = saveButton!
        
        dismissButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapDismissButton(_:)))
        navigationItem.leftBarButtonItem = dismissButton!
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        // Cells
        exerciseNameCell.textField.placeholder = "FTNewExerciseViewController_ExercisePlaceholder".ft_localized
        
        timerCell.mainLabel.text = "FTNewExerciseViewController_RestTimer".ft_localized
        let timer = FTStringFormatter.shared.formatAsMinutes(seconds: FTSettingsManager.shared.preferredRestTime)
        timerCell.detailLabel.text = timer
        
        pickerCell.delegate = self
        pickerCell.setPickerTimer(seconds: FTSettingsManager.shared.preferredRestTime, animated: false)
    }
    
    private func updateBodyPartCell() {
        bodyPartCell.mainLabel.text = "FTNewExerciseViewController_BodyPart".ft_localized
        bodyPartCell.detailLabel.text = exercise.getBodyPart().description
        bodyPartCell.detailLabel.textColor = FTColours.grayTextColour
    }
    
    private func updateCategoryCell() {
        categoryCell.mainLabel.text = "FTNewExerciseViewController_Category".ft_localized
        categoryCell.detailLabel.text = exercise.getCategory().description
        categoryCell.detailLabel.textColor = FTColours.grayTextColour
    }
    
    private func shake(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        
        view.layer.add(animation, forKey: "position")
    }
    
    private func handleNonCompleteExercise() {
        if exercise.getBodyPart() == .none {
            bodyPartCell.detailLabel.textColor = FTColours.missingColour
            shake(bodyPartCell.detailLabel)
        }
        
        if exercise.getCategory() == .none {
            categoryCell.detailLabel.textColor = FTColours.missingColour
            shake(categoryCell.detailLabel)
        }
        
        if exercise.name == nil || exercise.name == "" {
            exerciseNameCell.textField.placeholderColour = FTColours.missingColour
            shake(exerciseNameCell.textField)
        }
    }

    @objc private func didTapSaveButton(_ sender: UIBarButtonItem) {
        guard exercise.isComplete else {
            handleNonCompleteExercise()
            return
        }
        
        do {
            try context.save()
            try context.parent?.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDismissButton(_ sender: UIBarButtonItem) {
        if exercise.name != nil {
            // TODO: Double check with user.
            self.context.rollback()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func textFieldDidChangeNotification(_ notification: Notification) {
        exerciseNameCell.textField.placeholderColour = exerciseNameCell.defaultPlaceholderColour
        exercise.name = exerciseNameCell.textField.text
    }
    
    private func hidePickerCell() {
        // We need to set this here so the tableview rows are correctly updated.
        isPickerCellHidden = !isPickerCellHidden
        tableView.beginUpdates()
        tableView.deleteRows(at: [pickerCellIndex], with: .fade)
        tableView.endUpdates()
    }
    
    private func showPickerCell() {
        // We need to set this here so the tableview rows are correctly updated.
        isPickerCellHidden = !isPickerCellHidden
        tableView.beginUpdates()
        tableView.insertRows(at: [pickerCellIndex], with: .fade)
        tableView.endUpdates()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath == pickerCellIndex ? 150 : 50
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section] ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellMap[indexPath]
        
        assert(cell != nil, "Unmapped IndexPath")
        
        return cell ?? UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = cellMap[indexPath] else {
            assertionFailure("Unknown cell at indexPath")
            return
        }
        
        if cell == bodyPartCell {
            detailVC.detailType = .bodyPart
            detailVC.title = "FTGeneral_BodyPart".ft_localized
            detailVC.exercise = exercise
            detailVC.selectedIndex = Int(exercise.getBodyPart().rawValue)
            detailVC.options = FTExercise.BodyPart.array
            navigationController?.pushViewController(detailVC, animated: true)
        } else if cell == categoryCell {
            detailVC.detailType = .category
            detailVC.title = "FTGeneral_Category".ft_localized
            detailVC.exercise = exercise
            detailVC.selectedIndex = Int(exercise.getCategory().rawValue)
            detailVC.options = FTExercise.Category.array
            navigationController?.pushViewController(detailVC, animated: true)
        } else if cell == timerCell {
            isPickerCellHidden ? showPickerCell() : hidePickerCell()
        }
    }
    
    // MARK: - FTTimerPickerCellDelegate
    
    func timerPickerCell(_ cell: FTTimerPickerCell, didUpdateTimerValueTo value: Int) {
        let timer = FTStringFormatter.shared.formatAsMinutes(seconds: value)
        timerCell.detailLabel.text = timer
    }
}
