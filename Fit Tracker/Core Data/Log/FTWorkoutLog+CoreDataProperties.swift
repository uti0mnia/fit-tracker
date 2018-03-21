//
//  FTWorkoutLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
//
//

import Foundation
import CoreData


extension FTWorkoutLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTWorkoutLog> {
        return NSFetchRequest<FTWorkoutLog>(entityName: "FTWorkoutLog")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var groupLogs: NSOrderedSet?
    @NSManaged public var workoutTemplate: FTWorkoutTemplate?

}

// MARK: Generated accessors for groupLogs
extension FTWorkoutLog {

    @objc(insertObject:inGroupLogsAtIndex:)
    @NSManaged public func insertIntoGroupLogs(_ value: FTExerciseGroupLog, at idx: Int)

    @objc(removeObjectFromGroupLogsAtIndex:)
    @NSManaged public func removeFromGroupLogs(at idx: Int)

    @objc(insertGroupLogs:atIndexes:)
    @NSManaged public func insertIntoGroupLogs(_ values: [FTExerciseGroupLog], at indexes: NSIndexSet)

    @objc(removeGroupLogsAtIndexes:)
    @NSManaged public func removeFromGroupLogs(at indexes: NSIndexSet)

    @objc(replaceObjectInGroupLogsAtIndex:withObject:)
    @NSManaged public func replaceGroupLogs(at idx: Int, with value: FTExerciseGroupLog)

    @objc(replaceGroupLogsAtIndexes:withGroupLogs:)
    @NSManaged public func replaceGroupLogs(at indexes: NSIndexSet, with values: [FTExerciseGroupLog])

    @objc(addGroupLogsObject:)
    @NSManaged public func addToGroupLogs(_ value: FTExerciseGroupLog)

    @objc(removeGroupLogsObject:)
    @NSManaged public func removeFromGroupLogs(_ value: FTExerciseGroupLog)

    @objc(addGroupLogs:)
    @NSManaged public func addToGroupLogs(_ values: NSOrderedSet)

    @objc(removeGroupLogs:)
    @NSManaged public func removeFromGroupLogs(_ values: NSOrderedSet)

}
