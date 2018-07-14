//
//  FTAbstractGroup+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTAbstractGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTAbstractGroup> {
        return NSFetchRequest<FTAbstractGroup>(entityName: "FTAbstractGroup")
    }

    @NSManaged public var index: Int16
    @NSManaged public var exercises: NSSet?
    @NSManaged public var workout: FTAbstractWorkout?

}

// MARK: Generated accessors for exercises
extension FTAbstractGroup {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: FTAbstractExercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: FTAbstractExercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
