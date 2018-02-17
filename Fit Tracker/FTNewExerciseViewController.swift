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
    private static let cellHeight: CGFloat = 60
    
    private let detailVC = FTNewExerciseDetailViewController()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVisuals()
    }
    
    private func setupVisuals() {
        title = "FTNewExerciseViewController_Title".localized
        
        
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
        cell.textField.placeholder = "FTNewExerciseViewController_ExercisePlaceholder".localized
        cell.textField.text = self.name
        return cell
    }
    
    private func newChooseValueCell(title: String, detail: String) -> FTNewExerciseSelectionCell {
        let cell = FTNewExerciseSelectionCell()
        cell.mainLabel.text = title
        cell.detailLabel.text = detail
        return cell
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
            return newTextFieldCell()
        }
        
        // Body Part/Category.
        if section == 1 {
            let title = (row == 0) ? "FTNewExerciseViewController_BodyPart".localized : "FTNewExerciseViewController_Category".localized
            return newChooseValueCell(title: title, detail: "FTGeneral_None".localized)
        }
        
        // Timer.
        let title = "FTNewExerciseViewController_TestTimer".localized
        let time = FTStringFormatter.shared.formatAsMinutes(seconds: FTSettingsManager.shared.prefferedRestTime)
        let detail = String(format: "FTNewExerciseViewController_RestTimerValue".localized, time)
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
