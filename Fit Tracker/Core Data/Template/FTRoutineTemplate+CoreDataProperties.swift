//
//  FTRoutineTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
//
//

import Foundation
import CoreData


extension FTRoutineTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTRoutineTemplate> {
        return NSFetchRequest<FTRoutineTemplate>(entityName: "FTRoutineTemplate")
    }

    @NSManaged public var name: String?
    @NSManaged public var workouts: NSOrderedSet?

}

// MARK: Generated accessors for workouts
extension FTRoutineTemplate {

    @objc(insertObject:inWorkoutsAtIndex:)
    @NSManaged public func insertIntoWorkouts(_ value: FTWorkoutTemplate, at idx: Int)

    @objc(removeObjectFromWorkoutsAtIndex:)
    @NSManaged public func removeFromWorkouts(at idx: Int)

    @objc(insertWorkouts:atIndexes:)
    @NSManaged public func insertIntoWorkouts(_ values: [FTWorkoutTemplate], at indexes: NSIndexSet)

    @objc(removeWorkoutsAtIndexes:)
    @NSManaged public func removeFromWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceWorkouts(at idx: Int, with value: FTWorkoutTemplate)

    @objc(replaceWorkoutsAtIndexes:withWorkouts:)
    @NSManaged public func replaceWorkouts(at indexes: NSIndexSet, with values: [FTWorkoutTemplate])

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: FTWorkoutTemplate)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: FTWorkoutTemplate)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSOrderedSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSOrderedSet)

}
