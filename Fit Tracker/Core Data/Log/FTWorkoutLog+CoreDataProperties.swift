//
//  FTWorkoutLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
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
    @NSManaged public var exerciseLogs: Set<FTExerciseLog>?
    @NSManaged public var workoutTemplate: FTWorkoutTemplate?

}

// MARK: Generated accessors for exerciseLogs
extension FTWorkoutLog {

    @objc(addExerciseLogsObject:)
    @NSManaged public func addToExerciseLogs(_ value: FTExerciseLog)

    @objc(removeExerciseLogsObject:)
    @NSManaged public func removeFromExerciseLogs(_ value: FTExerciseLog)

    @objc(addExerciseLogs:)
    @NSManaged public func addToExerciseLogs(_ values: NSSet)

    @objc(removeExerciseLogs:)
    @NSManaged public func removeFromExerciseLogs(_ values: NSSet)

}
