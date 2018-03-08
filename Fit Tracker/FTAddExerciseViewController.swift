//
//  FTAddExerciseViewController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-21.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit
import CoreData

protocol FTAddExerciseViewControllerDelegate: class {
    func addExerciseViewController(_ controller: FTAddExerciseViewController, willDismissWithAddedExerciseGroups groups: [FTExerciseGroupTemplate])
}

class FTAddExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    private static let cellReuse = "cell"
    
    public weak var delegate: FTAddExerciseViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: FTAddExerciseViewController.cellReuse)
        tv.rowHeight = FTLayout.defaultTableViewCellHeight
        return tv
    }()
    
    private var selectedExercisesIndexPaths = [IndexPath]() {
        didSet {
            let count = selectedExercisesIndexPaths.count
            addExerciseButton.setTitle(String(format: "FTAddExerciseViewController_AddExercise".ft_localized, count), for: .normal)
            
            if count > 1 {
                addSupersetButton.setTitle(String(format: "FTAddExerciseViewController_AddSuperset".ft_localized, count), for: .normal)
            } else {
                addSupersetButton.setTitle("FTAddExerciseViewController_DisabledSuperset".ft_localized, for: .normal)
            }
            addSupersetButton.isEnabled = count > 1
        }
    }
    
    private let newButton = UIBarButtonItem(title: "FTAddExerciseViewController_New".ft_localized, style: .plain, target: nil, action: nil)
//    private let newButton = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
    private let addExerciseButton = FTStrongButton()
    private let addExerciseView = UIView()
    private let addSupersetButton = FTSimpleButton()
    private let addSupersetView = UIView()
    
    private let context: NSManagedObjectContext
    private lazy var frc: NSFetchedResultsController<FTExercise> = {
        let request = NSFetchRequest<FTExercise>(entityName: "FTExercise")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: "firstLetter", cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    required init() {
        self.context = FTDataController.shared.moc
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisuals()
        addConstraints()
        
        do {
            try frc.performFetch()
        } catch {
            print("Error performing fetch: \(error.localizedDescription)")
            assertionFailure("frc failed")
        }
    }
    
    private func setupVisuals() {
        self.title = "FTAddExerciseViewController_Title".ft_localized
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        view.backgroundColor = FTColours.lightBackground
        view.addSubview(tableView)
        view.addSubview(addExerciseView)
        view.addSubview(addSupersetView)
        
        tableView.sectionIndexColor = FTColours.mainPrimary
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem = newButton
        navigationController?.navigationBar.tintColor = FTColours.mainPrimary
        
        addExerciseView.addSubview(addExerciseButton)
        addSupersetView.addSubview(addSupersetButton)
        
        newButton.target = self
        newButton.action = #selector(didTapNewButton(_:))
        
        let count = selectedExercisesIndexPaths.count
        addExerciseButton.setTitle(String(format: "FTAddExerciseViewController_AddExercise".ft_localized, count), for: .normal)
        addExerciseButton.addTarget(self, action: #selector(didTapAddExercisesButton(_:)), for: .touchUpInside)
        
        addSupersetButton.setTitle("FTAddExerciseViewController_DisabledSuperset".ft_localized, for: .normal)
        addSupersetButton.addTarget(self, action: #selector(didTapAddSupersetButton(_:)), for: .touchUpInside)
        addSupersetButton.isEnabled = false
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
//            make.bottom.equalToSuperview()
            make.height.equalTo(FTLayout.tallButtonHeight)
        }
    }
    
    @objc private func didTapNewButton(_ sender: UIBarButtonItem) {
        let vc = FTNewExerciseViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapAddExercisesButton(_ sender: UIButton) {
        guard delegate != nil else {
            assertionFailure("Cannot have a nil delegate.")
            _ = navigationController?.popViewController(animated: true)
            return
        }
        
        print("Adding exercises from selected array")
        
        var groups = [FTExerciseGroupTemplate]()
        for (idx, indexPath) in self.selectedExercisesIndexPaths.enumerated() {
            let groupTemplate = FTExerciseGroupTemplate(context: context)
            groupTemplate.index = Int16(idx)
            
            let exerciseTemplate = FTExerciseTemplate(context: context)
            exerciseTemplate.index = 0
            exerciseTemplate.exercise = self.frc.object(at: indexPath)
            exerciseTemplate.groupTemplate = groupTemplate
            
            // Create a default set template
            let setTemplate = FTSetTemplate.defaultSetTemplate(context: context)
            setTemplate.exerciseTemplate = exerciseTemplate
            
            groups.append(groupTemplate)
        }
        
        print("Finished adding exercises from selected array")
        
        delegate?.addExerciseViewController(self, willDismissWithAddedExerciseGroups: groups)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapAddSupersetButton(_ sender: UIButton) {
        print("Tapped add superset button")
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedExercisesIndexPaths.append(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        if let idx = selectedExercisesIndexPaths.index(of: indexPath) {
            selectedExercisesIndexPaths.remove(at: idx)
        }
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
        cell.selectionStyle = .none
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
