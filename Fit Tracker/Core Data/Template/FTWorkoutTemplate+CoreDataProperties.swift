//
//  FTWorkoutTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTWorkoutTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTWorkoutTemplate> {
        return NSFetchRequest<FTWorkoutTemplate>(entityName: "FTWorkoutTemplate")
    }

    @NSManaged public var colour: Int16
    @NSManaged public var dayOfWeek: Int16
    @NSManaged public var index: Int16
    @NSManaged public var isArchived: Bool
    @NSManaged public var isDefault: Bool
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var groupTemplates: NSSet?
    @NSManaged public var routine: FTRoutineTemplate?
    @NSManaged public var workoutLogs: NSSet?

}

// MARK: Generated accessors for groupTemplates
extension FTWorkoutTemplate {

    @objc(addGroupTemplatesObject:)
    @NSManaged public func addToGroupTemplates(_ value: FTExerciseGroupTemplate)

    @objc(removeGroupTemplatesObject:)
    @NSManaged public func removeFromGroupTemplates(_ value: FTExerciseGroupTemplate)

    @objc(addGroupTemplates:)
    @NSManaged public func addToGroupTemplates(_ values: NSSet)

    @objc(removeGroupTemplates:)
    @NSManaged public func removeFromGroupTemplates(_ values: NSSet)

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
