//
//  FTAbstractExercise+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTAbstractExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTAbstractExercise> {
        return NSFetchRequest<FTAbstractExercise>(entityName: "FTAbstractExercise")
    }

    @NSManaged public var index: Int16
    @NSManaged public var notes: String?
    @NSManaged public var group: FTAbstractGroup?
    @NSManaged public var sets: NSSet?
    @NSManaged public var exercise: FTExercise?

}

// MARK: Generated accessors for sets
extension FTAbstractExercise {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: FTAbstractSet)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: FTAbstractSet)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}
