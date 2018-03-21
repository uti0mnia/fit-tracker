//
//  FTExerciseGroupLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
//
//

import Foundation
import CoreData


extension FTExerciseGroupLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseGroupLog> {
        return NSFetchRequest<FTExerciseGroupLog>(entityName: "FTExerciseGroupLog")
    }

    @NSManaged public var exerciseLogs: NSOrderedSet?
    @NSManaged public var workoutLog: FTWorkoutLog?

}

// MARK: Generated accessors for exerciseLogs
extension FTExerciseGroupLog {

    @objc(insertObject:inExerciseLogsAtIndex:)
    @NSManaged public func insertIntoExerciseLogs(_ value: FTExerciseLog, at idx: Int)

    @objc(removeObjectFromExerciseLogsAtIndex:)
    @NSManaged public func removeFromExerciseLogs(at idx: Int)

    @objc(insertExerciseLogs:atIndexes:)
    @NSManaged public func insertIntoExerciseLogs(_ values: [FTExerciseLog], at indexes: NSIndexSet)

    @objc(removeExerciseLogsAtIndexes:)
    @NSManaged public func removeFromExerciseLogs(at indexes: NSIndexSet)

    @objc(replaceObjectInExerciseLogsAtIndex:withObject:)
    @NSManaged public func replaceExerciseLogs(at idx: Int, with value: FTExerciseLog)

    @objc(replaceExerciseLogsAtIndexes:withExerciseLogs:)
    @NSManaged public func replaceExerciseLogs(at indexes: NSIndexSet, with values: [FTExerciseLog])

    @objc(addExerciseLogsObject:)
    @NSManaged public func addToExerciseLogs(_ value: FTExerciseLog)

    @objc(removeExerciseLogsObject:)
    @NSManaged public func removeFromExerciseLogs(_ value: FTExerciseLog)

    @objc(addExerciseLogs:)
    @NSManaged public func addToExerciseLogs(_ values: NSOrderedSet)

    @objc(removeExerciseLogs:)
    @NSManaged public func removeFromExerciseLogs(_ values: NSOrderedSet)

}
