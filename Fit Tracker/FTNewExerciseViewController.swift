//
//  FTNewExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-16.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTNewExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private static let sectionCount = 3
    private static let sectionRowCount: [Int] = [1, 2, 1]
    private static let cellHeight: CGFloat = 50
    
    private static let restTimers = [15, 30, 45, 60, 90, 120, 300]
    
    private let detailVC = FTNewExerciseDetailViewController()
    
    // Refactor to be lazy init so they're not optional.
    private var saveButton: UIBarButtonItem?
    private var dismissButton: UIBarButtonItem?
    
    private var exerciseNameCell: FTTextFieldTableViewCell?

    // Set as lazy so I can use self lol.
    private lazy var tableView: UITableView = { [unowned self] in
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.rowHeight = FTNewExerciseViewController.cellHeight
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    private var name: String?
    
    required init(withExerciseName name: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVisuals()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChangeNotification(_:)), name: .UITextFieldTextDidChange, object: nil)
    }
    
    private func setupVisuals() {
        title = "FTNewExerciseViewController_Title".ft_localized
        view.backgroundColor = FTColours.lightBackground
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveButton(_:)))
        saveButton?.tintColor = FTColours.mainPrimary
        saveButton?.isEnabled = false
        self.navigationItem.rightBarButtonItem = saveButton!
        
        dismissButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapDismissButton(_:)))
        dismissButton?.tintColor = FTColours.mainPrimary
        self.navigationItem.leftBarButtonItem = dismissButton!
        
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
        cell.textField.text = self.name
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
        
    }
    
    @objc private func didTapDismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            self.exerciseNameCell?.textField.text = nil
        }
    }
    
    @objc private func textFieldDidChangeNotification(_ notification: Notification) {
        updateSaveButton()
    }
    
    // MARK: - UITableViewDataSource
    
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
            return newChooseValueCell(title: title, detail: "FTGeneral_None".ft_localized)
        }
        
        // Timer.
        let title = "FTNewExerciseViewController_TestTimer".ft_localized
        let time = FTStringFormatter.shared.formatAsMinutes(seconds: FTSettingsManager.shared.preferredRestTime)
        let detail = String(format: "FTNewExerciseViewController_RestTimerValue".ft_localized, time)
        return newChooseValueCell(title: title, detail: detail)
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var opts: [CustomStringConvertible]!
        
        if section == 1 {
            opts = (row == 0) ? FTExercise.BodyPart.array : FTExercise.Category.array
        } else {
            opts = FTNewExerciseViewController.restTimers
        }
        
        detailVC.options = opts
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITextFieldDelegate

    
}
