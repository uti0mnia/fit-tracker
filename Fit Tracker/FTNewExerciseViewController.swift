//
//  FTNewExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTNewExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, FTNewExerciseDetailViewControllerDelegate, FTTimerPickerCellDelegate {
    
    private static let sectionCount = 3
    private static let sectionRowCount: [Int] = [1, 2, 1]
    private static let cellHeight: CGFloat = 50
    
    private static let restTimers = [0, 15, 30, 45, 60, 90, 120, 300]
    
    private let detailVC = FTNewExerciseDetailViewController()
    
    // Refactor to be lazy init so they're not optional.
    private var saveButton: UIBarButtonItem?
    private var dismissButton: UIBarButtonItem?
    
    private var exerciseNameCell: FTTextFieldTableViewCell?
    private var timerCell: FTExerciseSelectionCell?
    
    private var context: NSManagedObjectContext

    // Set as lazy so I can use self lol.
    private var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.rowHeight = UITableViewAutomaticDimension
        return tv
    }()
    private var exercise: FTExercise?
    
    required init() {
        self.context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        super.init(nibName: nil, bundle: nil)
        
        self.context.parent = (UIApplication.shared.delegate as! AppDelegate).dataController.moc
        exercise = FTExercise(context: context)
        exercise?.createdAt = NSDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        detailVC.delegate = self

        setupVisuals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChangeNotification(_:)), name: .UITextFieldTextDidChange, object: nil)
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
        saveButton?.isEnabled = false
        navigationItem.rightBarButtonItem = saveButton!
        
        dismissButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapDismissButton(_:)))
        navigationItem.leftBarButtonItem = dismissButton!
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
    
    private func newTextFieldCell() -> FTTextFieldTableViewCell {
        let cell = FTTextFieldTableViewCell()
        cell.textField.delegate = self
        cell.textField.placeholder = "FTNewExerciseViewController_ExercisePlaceholder".ft_localized
        cell.selectionStyle = .none
        return cell
    }
    
    private func newChooseValueCell(title: String, detail: String) -> FTExerciseSelectionCell {
        let cell = FTExerciseSelectionCell()
        cell.mainLabel.text = title
        cell.detailLabel.text = detail
        return cell
    }
    
    private func updateSaveButton() {
        guard let cell = exerciseNameCell else {
            return
        }
        
        if cell.textField.text != nil && cell.textField.text != "" {
            saveButton?.isEnabled = true
        } else {
            saveButton?.isEnabled = false
        }
    }

    @objc private func didTapSaveButton(_ sender: UIBarButtonItem) {
        assert(exercise?.isComplete ?? false, "Saving uncomplete exercise")
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDismissButton(_ sender: UIBarButtonItem) {
        if exercise?.name != nil {
            // TODO: Double check with user.
            context.rollback()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func textFieldDidChangeNotification(_ notification: Notification) {
        updateSaveButton()
        exercise?.name = exerciseNameCell?.textField.text
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return FTNewExerciseViewController.sectionCount
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FTNewExerciseViewController.sectionRowCount[section]
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        // Exercise name.
        if section == 0 {
            if exerciseNameCell == nil {
                exerciseNameCell = newTextFieldCell()
            }
            return exerciseNameCell!
        }
        
        // Body Part/Category.
        if section == 1 {
            let title = (row == 0) ? "FTNewExerciseViewController_BodyPart".ft_localized : "FTNewExerciseViewController_Category".ft_localized
            let cell = newChooseValueCell(title: title, detail: "FTGeneral_None".ft_localized)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        // Timer.
        let cell = FTTimerPickerCell()
        cell.delegate = self
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            return
        } else if indexPath.section == 1 {
            let row = indexPath.row
            var opts: [CustomStringConvertible]!
            var selectedIndex: IndexPath?
            
            opts = (row == 0) ? FTExercise.BodyPart.array : FTExercise.Category.array
            if let idx = (row == 0) ? exercise?.bodyPart : exercise?.category {
                selectedIndex = IndexPath(row: Int(idx), section: 0)
            }
            
            detailVC.options = opts
            detailVC.selectedIndex = selectedIndex
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            if let cell = tableView.cellForRow(at: indexPath) as? FTTimerPickerCell {
                cell.togglePickerView()
            }
        }
    }
    
    // MARK: - UITextFieldDelegate

    // MARK: - FTNewExerciseDetailViewControllerDelegate
    
    func newExerciseDetailViewController(_ viewController: FTNewExerciseViewController, willDismissWithSelectedIndexPath indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        
        
    }
    
    // MARK: - FTTimerPickerCellDelegate
    
    func timerPickerCell(_ cell: FTTimerPickerCell, didUpdateTimerValueTo value: Int) {
        
    }
}
