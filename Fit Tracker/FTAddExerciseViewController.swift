//
//  FTAddExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-21.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

class FTAddExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private var selectedExercises = [FTExerciseTemplate]()
    
    private let newButton = UIBarButtonItem(title: "FTAddExerciseViewController_New".ft_localized, style: .plain, target: nil, action: nil)
    private let addExerciseButton = FTButtonFactory.simpleButton()
    private let addSupersetButton = FTButtonFactory.countourButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        addConstraints()
    }
    
    private func setupVisuals() {
        self.title = "FTAddExerciseViewController_Title".ft_localized
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        view.backgroundColor = FTColours.lightBackground
        view.addSubview(tableView)
        view.addSubview(addExerciseButton)
        view.addSubview(addSupersetButton)
        
        navigationItem.rightBarButtonItem = newButton
        navigationController?.navigationBar.tintColor = FTColours.mainPrimary
        
        newButton.target = self
        newButton.action = #selector(didTapNewButton(_:))
        
        addExerciseButton.setTitle("FTAddExerciseViewController_AddExercise".ft_localized, for: .normal)
        addExerciseButton.addTarget(self, action: #selector(didTapAddExercisesButton(_:)), for: .touchUpInside)
        
        addSupersetButton.setTitle("FTAddExerciseViewController_AddSuperset".ft_localized, for: .normal)
        addSupersetButton.addTarget(self, action: #selector(didTapAddSupersetButton(_:)), for: .touchUpInside)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints() { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [addSupersetButton, addExerciseButton])
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.snp.makeConstraints() { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
            make.height.equalTo(FTLayout.defaultButtonHeight)
        }
    }
    
    @objc private func didTapNewButton(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func didTapAddExercisesButton(_ sender: UIButton) {
        
    }
    
    @objc private func didTapAddSupersetButton(_ sender: UIButton) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
