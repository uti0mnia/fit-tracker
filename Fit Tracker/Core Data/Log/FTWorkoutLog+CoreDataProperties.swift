//
//  FTWorkoutLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-21.
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
    @NSManaged public var groupLogs: Set<FTExerciseGroupLog>?
    @NSManaged public var workoutTemplate: FTWorkoutTemplate?

}

// MARK: Generated accessors for groupLogs
extension FTWorkoutLog {

    @objc(addGroupLogsObject:)
    @NSManaged public func addToGroupLogs(_ value: FTExerciseGroupLog)

    @objc(removeGroupLogsObject:)
    @NSManaged public func removeFromGroupLogs(_ value: FTExerciseGroupLog)

    @objc(addGroupLogs:)
    @NSManaged public func addToGroupLogs(_ values: NSSet)

    @objc(removeGroupLogs:)
    @NSManaged public func removeFromGroupLogs(_ values: NSSet)

}
