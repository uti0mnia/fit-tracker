////
////  FTRealmFetchController.swift
////  Fit Tracker
////
////  Created by Casey McLewin on 2018-01-30.
////  Copyright © 2018 Casey McLewin. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//typealias InitCompletion = (Bool, Error?) -> Void
//
//protocol FTRealmFetchControllerDelegate: class {
//    func realmFetchControllerWillChangeResults<T>(_ controller: FTRealmFetchController<T>)
//    func realmFetchControllerDidChageResults<T>(_ controller: FTRealmFetchController<T>)
//
//    func realmFetchControllerDidFetchResults<T>(_ controller: FTRealmFetchController<T>)
//    func realmFetchController<T>(_ controller: FTRealmFetchController<T>,
//                                 didChangeObjectAt indexPath: IndexPath,
//                                 for type: FTRealmFetchController<T>.RealmFetchControllerChangeType)
//    func realmFetchController<T>(_ controller: FTRealmFetchController<T>,
//                                 didChangeSectionName name: String,
//                                 atSectionIndex section: Int,
//                                 for type: FTRealmFetchController<T>.RealmFetchControllerChangeType) // only insert/delete
//
//    func realmFetchController<T>(_ controller: FTRealmFetchController<T>, didReceiveErrorWhileUpdating error: Error)
//    func realmFetchController<T>(_ controller: FTRealmFetchController<T>, didFailToPerformFetchWithError error: FTRealmFetchController<T>.RealmFetchControllerError)
//}
//
//// TODO: Implement some caching.
//// This class can be intialized to use different threads, but will always return calls to the thread that called it.
//class FTRealmFetchController<T: Object>: NSObject {
//    public enum RealmFetchControllerError: Error {
//        case noRealmConfigured
//        case unknown
//    }
//
//    public enum RealmFetchControllerChangeType {
//        case insert
//        case modify
//        case delete
//    }
//
//    private final class FTRealmSection<T: Object> {
//
//        public var results: Results<T>
//        public var notificationToken: NotificationToken?
//
//        init(results: Results<T>, notificationToken: NotificationToken? = nil) {
//            self.results = results
//            self.notificationToken = notificationToken
//        }
//
//        deinit {
//            notificationToken?.invalidate()
//        }
//
//    }
//
//    public weak var delegate: FTRealmFetchControllerDelegate?
//
//    private var realm: Realm?
//
//    private var results: Results<T>?
//    private var sectionsDict = [String: FTRealmSection<T>]()
//    public var sectionNames: [String]? {
//        // Cache this.
//        guard let results = results,
//        let property = fetchRequest?.sectionProperty,
//        let items = results.value(forKeyPath: property) as? [String] else {
//            return nil
//        }
//
//        return Set(items).sorted()
//    }
//
//    public var fetchRequest: FTRealmFetchRequest?
//    private var isSectioned: Bool {
//        return fetchRequest?.sectionProperty != nil
//    }
//
//    private var notificationToken: NotificationToken?
//
//    // TODO: Verify this description makes sense.
//    // We do not offer a queue to return the data on since this is meant to be used as a controller to help with updating UI
//    // which should be done on the main queue. Writing is a different story.
//    init(config: Realm.Configuration = .defaultConfiguration, completion: @escaping InitCompletion) {
//        super.init()
//
//        Realm.asyncOpen(configuration: config, callbackQueue: .main) { realm, error in
//            guard let realm = realm else {
//                completion(false, error)
//                return
//            }
//
//            self.realm = realm
//            completion(true, nil)
//        }
//    }
//
//    deinit {
//        notificationToken?.invalidate()
//    }
//
//    // This method must be called or else no updates will be sent to the delegate since there's no reference to the Resuls<T>.
//    // It is only necessary to call this if the fetchRequest is changed.
//    public func performFetch() {
//        guard let realm = self.realm else {
//            delegate?.realmFetchController(self, didFailToPerformFetchWithError: .noRealmConfigured)
//            return
//        }
//
//        results = realm.objects(T.self)
//
//        applyFetchRequest()
//        applyNotifications()
//
//    }
//
//    public func object(at indexPath: IndexPath) -> T? {
//        guard let results = results(atSection: indexPath.section) else {
//            return nil
//        }
//
//        return results.ft_safeAccess(at: indexPath.row)
//    }
//
//    public func indexPath(forObject object: T) -> IndexPath? {
//        // In this implementation, we do  not assume that the results are sorted based on the sectionProperty.
//        guard let property = fetchRequest?.sectionProperty,                 // Make sure there's a section property.
//            let value = object.value(forKey: property) as? String,          // Get the object's value for the section property.
//            let section = sections?.index(of: value),                       // The section index (to use for the IndexPath).
//            let sectionResults = results(atSection: section) else {         // Get the results for that section.
//                if let row = results?.index(of: object) {
//                    return IndexPath(row: row, section: 0)
//                }
//                return nil
//        }
//
//
//        var row = 0
//        for result in sectionResults {
//            if result == object {
//                return IndexPath(row: row, section: section)
//            }
//            row += 1
//        }
//
//        return IndexPath(row: row, section: section)
//    }
//
//    // MARK: General Helpers.
//
//    private func applyFetchRequest() {
//        sectionsDict.removeAll()
//
//        guard results != nil, let fetchRequest = fetchRequest else {
//            return
//        }
//
//        if let predicates = fetchRequest.predicates {
//            predicates.forEach() { predicate in
//                results = results?.filter(predicate)
//            }
//        }
//
//        if let descriptors = fetchRequest.sortDesciptors {
//            results = results?.sorted(by: descriptors)
//        }
//
//        // Update the dictionary to hold the sectionned results.
//        if let sectionProperty = fetchRequest.sectionProperty {
//            for section in sectionNames ?? [] {
//                sectionsDict[section] = FTRealmSection<T>(results: results!.filter("%@ == %@", sectionProperty, section))
//            }
//        }
//    }
//
//    private func applyNotifications() {
//        if isSectioned {
//            handleSectionedNotifications()
//        } else {
//            handleUnsectionedNotifications()
//        }
//    }
//
//    private func handleUnsectionedNotifications() {
//        guard let results = results else {
//            return
//        }
//
//        notificationToken = results.observe() { [weak self] changes in
//            guard let strongSelf = self else {
//                return
//            }
//
//            switch changes {
//            case .initial:
//                strongSelf.delegate?.realmFetchControllerDidFetchResults(strongSelf)
//            case .update(_, let deletions, let insertions, let modifications):
//                strongSelf.delegate?.realmFetchControllerWillChangeResults(strongSelf)
//
//                deletions.forEach() { idx in
//                    strongSelf.delegate?.realmFetchController(strongSelf, didChangeObjectAt: IndexPath(row: idx, section: 0), for: .delete)
//                }
//
//                insertions.forEach() { idx in
//                    strongSelf.delegate?.realmFetchController(strongSelf, didChangeObjectAt: IndexPath(row: idx, section: 0), for: .insert)
//                }
//
//                modifications.forEach() { idx in
//                    strongSelf.delegate?.realmFetchController(strongSelf, didChangeObjectAt: IndexPath(row: idx, section: 0), for: .modify)
//                }
//
//                strongSelf.delegate?.realmFetchControllerDidChageResults(strongSelf)
//            case .error(let error):
//                strongSelf.delegate?.realmFetchController(strongSelf, didReceiveErrorWhileUpdating: error)
//            }
//        }
//    }
//
//    private func handleSectionedNotifications() {
//        guard let results = results, let property = fetchRequest?.sectionProperty else {
//            return
//        }
//
//        notificationToken = results.observe() { [weak self] changes in
//            guard let strongSelf = self else {
//                return
//            }
//
//            switch changes {
//            case .update(_, _, let insertions, _):
//                for i in insertions {
//                    if let value = results[i].value(forKeyPath: property) as? String {
//                        if strongSelf.sectionsDict[value] == nil {
//                            strongSelf.sectionsDict[value] = FTRealmSection<T>(results: results.filter("%@ == %@", property, value))
//                            strongSelf.addNotificationToSection(value)
//                        }
//                    }
//                }
//            default:
//                break
//            }
//
//        }
//
//        sectionsDict.forEach({ addNotificationToSection($0.key) })
//    }
//
//    private func addNotificationToSection(_ section: String) {
//        guard let results = results, let realmSection = sectionsDict[section], let sectionNames = sectionNames else {
//            return
//        }
//
//        realmSection.notificationToken = results.observe() { [weak self] changes in
//            guard let strongSelf = self else {
//                return
//            }
//
//            switch changes {
//            case .initial:
//                strongSelf.delegate?.realmFetchControllerDidFetchResults(strongSelf)
//            case .update(_, let deletions, let insertions, let modifications):
//                // Handles deletion
//                if realmSection.results.count == 0 {
//                    if let idx = sectionNames.index(of: section) {
//                        strongSelf.delegate?.realmFetchController(strongSelf, didChangeSectionName: section, atSectionIndex: idx, for: .delete)
//                    }
//                } else {
//
//                }
//            }
//        }
//    }
//
//    // MARK: - Helpers for accessing values in sections.
//
//    private func results(atSection section: Int) -> Results<T>? {
//        guard let sections = sectionNames else {
//            return results
//        }
//        guard section < sections.count && section >= 0 else {
//            return nil
//        }
//        return results(inSection: sections[section])
//    }
//
//    private func results(inSection section: String) -> Results<T>? {
//        return sectionsDict[section]?.results
//    }
//
//    // MARK: - Helpers for sections after updating realm.
//
//    private func removedSectionsAferUpdate() -> Set<String>? {
//        guard let results = results, let property = fetchRequest?.sectionProperty, let sectionSet = sectionSet else {
//            return nil
//        }
//
//        // This is like really fucking slow. Figure out a better way to deal with sections please.
//        var returnSet = Set<String>()
//        for section in sectionSet {
//            if results.filter("%@ == %@", property, section).count == 0 {
//                returnSet.insert(section)
//            }
//        }
//
//        return returnSet
//    }
//
//    private func newSectionsAfterUpdate(insertions: [Int]) -> Set<String>? {
//        guard let results = results, let property = fetchRequest?.sectionProperty, let sectionSet = sectionSet else {
//            return nil
//        }
//
//        var returnSet = sectionSet
//
//        // We iterate through each insertion to see if we need a new section.
//        for i in insertions {
//            if let value = results.ft_safeAccess(at: i)?.value(forKey: property) as? String {
//                returnSet.insert(value)
//            }
//        }
//
//        return returnSet
//    }
//
//}

