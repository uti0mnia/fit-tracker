//
//  FTNewExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-07-25.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTNewExerciseProtocol {
    var exerciseOptionsCount: Int { get }
    var bodyPartDescription: String { get }
    var categoryDescription: String { get }
    var bodyPartTitles: [String] { get }
    var categoryTitles: [String] { get }
    var hasChanges: Bool { get }
    
    func mainText(forOptionIndex index: Int) -> String
    func detailText(forOptionIndex index: Int) -> String
    
    func optionTitles(forIndex index: Int) -> [String]
    func setOptionIndex(_ index: Int, forOptionIndex optionIndex: Int)
    
    func discardExercise()
    func applyChanges()
}

class FTNewExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    private static let cellReuse = "cellResuse"
    
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableView: FTTableView!
    
    public lazy var titleTextField: UITextField = {
        // TODO: Actually center this before I go crazy.
        let tf = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: 44))
        
        tf.delegate = self
        tf.borderStyle = .none
        tf.autocapitalizationType = .words
        tf.adjustsFontSizeToFitWidth = true
        tf.font = FTFonts.body
        tf.minimumFontSize = 9
        tf.textAlignment = .center
        
        return tf
    }()
    
    public var newExerciseViewModel: FTNewExerciseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = FTColours.mainTint

        navigationItem.titleView = titleTextField
        
        tableView.register(FTDetailCell.getNib(), forCellReuseIdentifier: FTNewExerciseViewController.cellReuse)
    }

    
    @IBAction private func handleCancelTap(_ sender: UIBarButtonItem) {
        // TODO: show warning if started editing
        if newExerciseViewModel?.hasChanges ?? false {
            let alert = UIAlertController(title: "Warning", message: "Are you sure you want to discard exercise?", preferredStyle: .alert)
            let discard = UIAlertAction(title: "Discard", style: .destructive) { _ in
                self.newExerciseViewModel?.discardExercise()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(discard)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func configure(_ cell: FTDetailCell, forIndexPath indexPath: IndexPath) {
        let sec = indexPath.section
        let row = indexPath.row
        
        if sec == 0 {
            if row == 0 {
                cell.mainLabel.text = "Body Part"
                cell.detailLabel.text = newExerciseViewModel?.bodyPartDescription ?? "None"
            } else {
                cell.mainLabel.text = "Category"
                cell.detailLabel.text = newExerciseViewModel?.categoryDescription ?? "None"
            }
        } else {
            cell.mainLabel.text = newExerciseViewModel?.mainText(forOptionIndex: row)
            cell.detailLabel.text = newExerciseViewModel?.detailText(forOptionIndex: row)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return newExerciseViewModel?.exerciseOptionsCount ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTNewExerciseViewController.cellReuse, for: indexPath) as! FTDetailCell
        configure(cell, forIndexPath: indexPath)
        return cell
    }
    
    // MARK: - UITextFieldDelegate
    
    // MARK: - UITextFieldDelegate
    
}
