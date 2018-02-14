//
//  FTMainWorkoutViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTMainWorkoutViewController: UIViewController {

    private let quickStackButton = FTButtonFactory.simpleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVisuals()
    }
    
    private func setupVisuals() {
        // Navigation bar.
        self.title = "Workouts"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // Quick add button.
        view.addSubview(quickStackButton)
        quickStackButton.snp.makeConstraints() { make in
            make.left.right.equalToSuperview().inset(Layout.defaultPadding)
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-Layout.defaultPadding)
            make.height.equalTo(Layout.simpleButtonHeight)
        }
        quickStackButton.setTitle(NSLocalizedString("FTMainWorkoutViewController_QuickStart", comment: ""), for: .normal)
        
        // New workout button.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton(_:)))
        addButton.tintColor = Colours.mainPrimary
        navigationController?.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButton(_ sender: Any) {
        
    }

}
