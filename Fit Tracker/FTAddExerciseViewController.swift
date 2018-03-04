//
//  FTAddExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-21.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

class FTAddExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    private static let cellReuse = "cell"
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: FTAddExerciseViewController.cellReuse)
        tv.rowHeight = FTLayout.defaultTableViewCellHeight
        return tv
    }()
    
    private var selectedExercises = [FTExerciseTemplate]()
    
    private let newButton = UIBarButtonItem(title: "FTAddExerciseViewController_New".ft_localized, style: .plain, target: nil, action: nil)
//    private let newButton = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
    private let addExerciseButton = FTButtonFactory.simpleButton()
    private let addSupersetButton = FTButtonFactory.countourButton()
    
    private lazy var frc: NSFetchedResultsController<FTExercise> = {
        let request = NSFetchRequest<FTExercise>(entityName: "FTExercise")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: FTDataController.shared.moc, sectionNameKeyPath: "firstLetter", cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        addConstraints()
        
        do {
            try frc.performFetch()
        } catch {
            assertionFailure("frc failed")
            print("Error performing fetch: \(error.localizedDescription)")
        }
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
        
        tableView.sectionIndexColor = FTColours.mainPrimary
        
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
        let vc = FTNewExerciseViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapAddExercisesButton(_ sender: UIButton) {
        
    }
    
    @objc private func didTapAddSupersetButton(_ sender: UIButton) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return frc.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FTAddExerciseViewController.cellReuse, for: indexPath)
        cell.textLabel?.text = frc.object(at: indexPath).name ?? ""
        return cell
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return frc.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return frc.section(forSectionIndexTitle: title, at: index)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return frc.sectionIndexTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return frc.sectionIndexTitles
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .fade)
        case .delete:
            tableView.deleteSections(indexSet, with: .fade)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
