//
//  DataController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-28.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import CoreData

class DataController: NSObject {
    
    public var moc: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    public var persistentContainer: NSPersistentContainer
    
    init(completion: @escaping () -> Void) {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores() { description, error in
            
            if let error = error {
                // TODO: Gracefull handle this.
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completion()
        }
    }
    
    public func saveContext() throws {
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                throw error
            }
        }
    }
}
