//
//  FTCreateWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-06-26.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

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
    
    private lazy var titleTextField: UITextField = {
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
    
    public var workout: FTAbstractWorkout? {
        didSet {
            workoutObserver = nil
            if let context = workout?.managedObjectContext {
                workoutObserver = FTCoreDataContextObserver(context: context)
            }
        }
    }
    private var workoutObserver: FTCoreDataContextObserver?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(workout != nil, "Workout shouldn't be nil")
        
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
        
        titleTextField.text = self.workout?.displayName ?? "New Workout"
        if workout == nil || workout?.groups?.count == 0 {
            handleEmptyWorkout()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleTextField.becomeFirstResponder()
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
        guard let workout = self.workout else {
            return
        }
        
        // TODO: Maybe not do unnecessary updates
        titleTextField.text = workout.displayName
        
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view == self.view && titleTextField.isEditing {
            titleTextField.resignFirstResponder()
        }
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
            self.workout?.displayName = textField.text ?? "" == "" ? "New Workout" : textField.text
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
























































