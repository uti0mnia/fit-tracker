//
//  FTCoreDataContextObserver.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-07-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import CoreData

class FTCoreDataContextObserver {
    
    public var enabled: Bool = true
    public let context: NSManagedObjectContext
    
    private var observedObjects = [NSManagedObject: (NSManagedObject) -> ()]()
    
    deinit {
        unobserveAllObjects()
        NotificationCenter.default.removeObserver(self, name: .NSManagedObjectContextObjectsDidChange, object: context)
    }
    
    public init(context: NSManagedObjectContext) {
        self.context = context
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleContextChange(_:)), name: .NSManagedObjectContextObjectsDidChange, object: context)
    }
    
    public func observeObject(object: NSManagedObject, completionBlock: @escaping (NSManagedObject) -> ()) {
        observedObjects[object] = completionBlock
    }
    
    public func unobserveObject(object: NSManagedObject) {
        observedObjects.removeValue(forKey: object)
    }
    
    public func unobserveAllObjects() {
        observedObjects.removeAll()
    }
    
    @objc private func handleContextChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, updates.count > 0 {
            updates.forEach({ observedObjects[$0]?($0) })
        }
    }
}

