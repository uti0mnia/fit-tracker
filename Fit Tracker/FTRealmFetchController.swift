//
//  FTRealmFetchController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-30.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

typealias InitCompletion = (Bool, Error?) -> Void

protocol FTRealmFetchControllerDelegate: class {
    func realmFetchControllerWillUpdateResults<T>(_ controller: FTRealmFetchController<T>)
    func realmFetchController<T>(_ controller: FTRealmFetchController<T>, didFailToPerformFetchWithError error: FTRealmFetchController<T>.RealmFetchControllerError)
}

// This class can be intialized to use different threads, but will always return calls to the thread that called it.
class FTRealmFetchController<T: Object>: NSObject {
    public enum RealmFetchControllerError: Error {
        case noRealmConfigured
        case unknown
    }
    
    public weak var delegate: FTRealmFetchControllerDelegate?
    
    private var realm: Realm?
    private(set) var results: Results<T>?
    private(set) var sections
    
    init(config: Realm.Configuration = .defaultConfiguration, queue: DispatchQueue = .main, completion: @escaping InitCompletion) {
        super.init()
        
        Realm.asyncOpen(configuration: config, callbackQueue: queue) { realm, error in
            guard let realm = realm else {
                completion(false, error)
                return
            }
            
            self.realm = realm
            completion(true, nil)
        }
    }
    
    // This method should be used in sync with delegate calls do retrieve information updates since this can be called on a background thread.
    public func performFetch() {
        guard let realm = self.realm else {
            delegate?.realmFetchController(self, didFailToPerformFetchWithError: .noRealmConfigured)
            return
        }
        
        delegate?.realmFetchControllerWillUpdateResults(self)
        
        
    }
    
    public func object(at: IndexPath) -> T? {
        guard let results = self.results else {
            return nil
        }
        
        return results[
    }
}
