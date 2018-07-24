//
//  FTExerciseGroupLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-24.
//
//

import Foundation
import CoreData


extension FTExerciseGroupLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseGroupLog> {
        return NSFetchRequest<FTExerciseGroupLog>(entityName: "FTExerciseGroupLog")
    }

    @NSManaged public var index: Int16
    @NSManaged public var exerciseLogs: Set<FTExerciseLog>?
    @NSManaged public var workoutLog: FTWorkoutLog?

}

// MARK: Generated accessors for exerciseLogs
extension FTExerciseGroupLog {

    @objc(addExerciseLogsObject:)
    @NSManaged public func addToExerciseLogs(_ value: FTExerciseLog)

    @objc(removeExerciseLogsObject:)
    @NSManaged public func removeFromExerciseLogs(_ value: FTExerciseLog)

    @objc(addExerciseLogs:)
    @NSManaged public func addToExerciseLogs(_ values: NSSet)

    @objc(removeExerciseLogs:)
    @NSManaged public func removeFromExerciseLogs(_ values: NSSet)

}
