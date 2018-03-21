//
//  FTExerciseLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
//
//

import Foundation
import CoreData


extension FTExerciseLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseLog> {
        return NSFetchRequest<FTExerciseLog>(entityName: "FTExerciseLog")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var exercise: FTExercise?
    @NSManaged public var groupLog: FTExerciseGroupLog?
    @NSManaged public var setLogs: NSOrderedSet?

}

// MARK: Generated accessors for setLogs
extension FTExerciseLog {

    @objc(insertObject:inSetLogsAtIndex:)
    @NSManaged public func insertIntoSetLogs(_ value: FTSetLog, at idx: Int)

    @objc(removeObjectFromSetLogsAtIndex:)
    @NSManaged public func removeFromSetLogs(at idx: Int)

    @objc(insertSetLogs:atIndexes:)
    @NSManaged public func insertIntoSetLogs(_ values: [FTSetLog], at indexes: NSIndexSet)

    @objc(removeSetLogsAtIndexes:)
    @NSManaged public func removeFromSetLogs(at indexes: NSIndexSet)

    @objc(replaceObjectInSetLogsAtIndex:withObject:)
    @NSManaged public func replaceSetLogs(at idx: Int, with value: FTSetLog)

    @objc(replaceSetLogsAtIndexes:withSetLogs:)
    @NSManaged public func replaceSetLogs(at indexes: NSIndexSet, with values: [FTSetLog])

    @objc(addSetLogsObject:)
    @NSManaged public func addToSetLogs(_ value: FTSetLog)

    @objc(removeSetLogsObject:)
    @NSManaged public func removeFromSetLogs(_ value: FTSetLog)

    @objc(addSetLogs:)
    @NSManaged public func addToSetLogs(_ values: NSOrderedSet)

    @objc(removeSetLogs:)
    @NSManaged public func removeFromSetLogs(_ values: NSOrderedSet)

}
