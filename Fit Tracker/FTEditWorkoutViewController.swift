//
//  FTCreateWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-26.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

protocol FTEditWorkoutModelProtocol {
    var workoutName: String? { get set }
    var exerciseCount: Int { get }
    func applyChanges()
}

protocol FTEditWorkoutInterfaceProtocol {
    var canEditWorkoutName: Bool { get }
    
}

class FTEditWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FTWorkoutInfoBarDelegate, UITextFieldDelegate {
    
    @IBOutlet private weak var infoBar: FTWorkoutInfoBar!
    @IBOutlet private weak var timerBar: FTTimerBar!
    @IBOutlet private weak var exerciseSetView: FTExerciseSetView!
    @IBOutlet private weak var exerciseTableView: FTTableView!
    @IBOutlet private weak var addExercisesButton: FTBottomButton!
    @IBOutlet private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private lazy var emptyView: FTEmptyWorkoutView = {
        let view = FTEmptyWorkoutView.instantiateFromNib()
        view.backgroundColor = FTColours.background
        view.mainLabel.text = "Get started by adding exercises!"
        return view
    }()
    
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
        tf.isUserInteractionEnabled = editWorkoutInterface?.canEditWorkoutName ?? false
        
        return tf
    }()
    
    public var editWorkoutInterface: FTEditWorkoutInterfaceProtocol?
    public var editWorkoutViewModel: FTEditWorkoutModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(editWorkoutViewModel != nil, "Workout model shouldn't be nil")
        assert(editWorkoutInterface != nil, "Workout interface shouldn't be nil")
        
        view.backgroundColor = FTColours.background
        
        exerciseSetView.tableView.delegate = self
        exerciseSetView.tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.titleView = titleTextField
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleTextField.text = editWorkoutViewModel?.workoutName ?? "New Workout"
        if editWorkoutViewModel?.exerciseCount ?? 0 == 0 {
            handleEmptyWorkout()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        titleTextField.resignFirstResponder()
        editWorkoutViewModel?.applyChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if editWorkoutInterface?.canEditWorkoutName ?? false && editWorkoutViewModel?.workoutName == nil {
            titleTextField.becomeFirstResponder()
        }
    }
    
    public static func instantiateFromStoryboard() -> FTEditWorkoutViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FTEditWorkoutViewController") as! FTEditWorkoutViewController
    }
    
    private func handleEmptyWorkout() {
        if emptyView.superview == nil {
            view.addSubview(emptyView)
            emptyView.snp.makeConstraints() { make in
                make.top.equalTo(timerBar.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(addExercisesButton.snp.top)
            }
        }
        emptyView.isHidden = false
        editButtonItem.isEnabled = false
        infoBar.disableAll()
    }
    
    private func hideEmptyWorkout() {
        emptyView.isHidden = true
        editButtonItem.isEnabled = true
        infoBar.enableAll()
    }
    
    private func handleWorkoutUpdate() {
        // TODO: Maybe not do unnecessary updates
        titleTextField.text = editWorkoutViewModel?.workoutName
        
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view == self.view && titleTextField.isEditing {
            titleTextField.resignFirstResponder()
        }
    }
    
    @IBAction private func handleAddExerciseButton(_ sender: Any) {
        
    }
    
    
    // MARK: - UITableViewDelegate
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    // MARK: - FTWorkoutInfoBarDelegate
    
    func workoutInfoBar(_ workoutInfoBar: FTWorkoutInfoBar, didTapButtonWithType type: FTWorkoutInfoBar.ButtonType) {
        // do nothing
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case titleTextField:
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
            view.subviews.forEach({ $0.isUserInteractionEnabled = false })
            tapGestureRecognizer.isEnabled = true
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case titleTextField:
            editWorkoutViewModel?.workoutName = textField.text ?? ""
            view.subviews.forEach({ $0.isUserInteractionEnabled = true })
            tapGestureRecognizer.isEnabled = false
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleTextField:
            textField.resignFirstResponder()
            return true
        default:
            return true
        }
        
    }
}
























































