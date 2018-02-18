//
//  FTHomeViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-10.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

// TODO: Figure out what kind of data I want to display.
class FTHomeViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    // Data items.
    private let exerciseDataView = FTHomeDataView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        setupData()
    }
    
    private func setupVisuals() {
        view.backgroundColor = Colours.lightBackground
        
        // Navigation bar.
        self.title = "Home"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        // ScrollView.
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clear
        scrollView.snp.makeConstraints() { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset = Layout.largeInsets
        
        // Data views.
        scrollView.addSubview(exerciseDataView)
        exerciseDataView.snp.makeConstraints() { make in
            make.width.equalToSuperview().inset(Layout.largeInsets)
            make.top.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.bottom).priority(250) // Low priority.
        }
    }
    
    private func setupData() {
        // Exercise data.
        exerciseDataView.mainLabel.text = "FTHomeViewController_Exercise".ft_localized
        exerciseDataView.subLabel.text = "\(20)"
    }
    
}




































