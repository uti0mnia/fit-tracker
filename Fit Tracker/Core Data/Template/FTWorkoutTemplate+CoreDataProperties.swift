//
//  FTWorkoutTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
//
//

import Foundation
import CoreData


extension FTWorkoutTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTWorkoutTemplate> {
        return NSFetchRequest<FTWorkoutTemplate>(entityName: "FTWorkoutTemplate")
    }

    @NSManaged public var isDefault: Bool
    @NSManaged public var name: String?
    @NSManaged public var groupTemplates: Set<FTExerciseGroupTemplate>?
    @NSManaged public var workoutLogs: Set<FTWorkoutLog>?

}

// MARK: Generated accessors for exerciseTemplates
extension FTWorkoutTemplate {

    @objc(addExerciseTemplatesObject:)
    @NSManaged public func addToExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(removeExerciseTemplatesObject:)
    @NSManaged public func removeFromExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(addExerciseTemplates:)
    @NSManaged public func addToExerciseTemplates(_ values: NSSet)

    @objc(removeExerciseTemplates:)
    @NSManaged public func removeFromExerciseTemplates(_ values: NSSet)

}

// MARK: Generated accessors for workoutLogs
extension FTWorkoutTemplate {

    @objc(addWorkoutLogsObject:)
    @NSManaged public func addToWorkoutLogs(_ value: FTWorkoutLog)

    @objc(removeWorkoutLogsObject:)
    @NSManaged public func removeFromWorkoutLogs(_ value: FTWorkoutLog)

    @objc(addWorkoutLogs:)
    @NSManaged public func addToWorkoutLogs(_ values: NSSet)

    @objc(removeWorkoutLogs:)
    @NSManaged public func removeFromWorkoutLogs(_ values: NSSet)

}
