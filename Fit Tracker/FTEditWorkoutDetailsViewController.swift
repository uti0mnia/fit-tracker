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

class FTEditWorkoutDetailsViewController: UIViewController, UITextFieldDelegate {
    
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
        detailScrollView.textField.delegate = self
        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveButton(_:)))
        navigationItem.rightBarButtonItem = save
    }
    
    private func displayErrorMessage() {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong saving. If this continues, try making a new workout. Sorry :(", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapSaveButton(_ sender: UIButton) {
        // Update the workout name since the user tapped save.
        workout.name = detailScrollView.textField.text
        
        guard workout.name != nil && workout.name != "" else {
            detailScrollView.nameLabel.ft_shake()
            return
        }
        
        do {
            try context.save()
            
            assert(self.navigationController != nil, "Um hello? How is this not in a NavController")
            
            self.navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            print("Error saving context: \(error.localizedDescription)")
            assertionFailure()
            
            displayErrorMessage()
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
