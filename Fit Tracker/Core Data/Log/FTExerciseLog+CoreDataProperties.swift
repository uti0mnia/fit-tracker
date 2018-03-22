//
//  FTExerciseLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-21.
//
//

import Foundation
import CoreData


extension FTExerciseLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseLog> {
        return NSFetchRequest<FTExerciseLog>(entityName: "FTExerciseLog")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var index: Int16
    @NSManaged public var exercise: FTExercise?
    @NSManaged public var groupLog: FTExerciseGroupLog?
    @NSManaged public var setLogs: Set<FTSetLog>?

}

// MARK: Generated accessors for setLogs
extension FTExerciseLog {

    @objc(addSetLogsObject:)
    @NSManaged public func addToSetLogs(_ value: FTSetLog)

    @objc(removeSetLogsObject:)
    @NSManaged public func removeFromSetLogs(_ value: FTSetLog)

    @objc(addSetLogs:)
    @NSManaged public func addToSetLogs(_ values: NSSet)

    @objc(removeSetLogs:)
    @NSManaged public func removeFromSetLogs(_ values: NSSet)

}
