//
//  DataController.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-28.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import CoreData

class FTDataController: NSObject {
    
    public static let shared = FTDataController()
    
    // Only to use with main thread
    public var moc: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private var persistentContainer: NSPersistentContainer
    
    private override init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores() { description, error in
            if let error = error {
                // TODO: Gracefull handle this.
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        super.init()
    }
    
    public func createMainContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = moc
        return context
    }
    
    public func createBackgroundContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = moc
        return context
    }
    
    public func saveContext() -> Error? {
        do {
            try moc.save()
        } catch {
            print("Error saving moc: \(error.localizedDescription)")
            return error
        }
        
        return nil
    }
    
    public func performSaveBlockAsync(block: @escaping (NSManagedObjectContext) -> Void, completion: @escaping (Error?) -> Void) throws {
        persistentContainer.performBackgroundTask() { context in
            block(context)
            
            do {
                try context.save()
                completion(nil)
            } catch {
                print("Error saving moc: \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    public func performSaveBlock(block: (NSManagedObjectContext) -> Void) -> Error? {
        block(moc)
        
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print("Error saving moc: \(error.localizedDescription)")
                return error
            }
        }
        
        return nil
    }
}