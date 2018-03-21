//
//  FTWorkoutTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
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
    @NSManaged public var isDefault: Bool
    @NSManaged public var name: String?
    @NSManaged public var groupTemplates: NSOrderedSet?
    @NSManaged public var routine: FTRoutineTemplate?
    @NSManaged public var workoutLogs: Set<FTWorkoutLog>?

}

// MARK: Generated accessors for groupTemplate
extension FTWorkoutTemplate {

    @objc(insertObject:inGroupTemplateAtIndex:)
    @NSManaged public func insertIntoGroupTemplate(_ value: FTExerciseGroupTemplate, at idx: Int)

    @objc(removeObjectFromGroupTemplateAtIndex:)
    @NSManaged public func removeFromGroupTemplate(at idx: Int)

    @objc(insertGroupTemplate:atIndexes:)
    @NSManaged public func insertIntoGroupTemplate(_ values: [FTExerciseGroupTemplate], at indexes: NSIndexSet)

    @objc(removeGroupTemplateAtIndexes:)
    @NSManaged public func removeFromGroupTemplate(at indexes: NSIndexSet)

    @objc(replaceObjectInGroupTemplateAtIndex:withObject:)
    @NSManaged public func replaceGroupTemplate(at idx: Int, with value: FTExerciseGroupTemplate)

    @objc(replaceGroupTemplateAtIndexes:withGroupTemplate:)
    @NSManaged public func replaceGroupTemplate(at indexes: NSIndexSet, with values: [FTExerciseGroupTemplate])

    @objc(addGroupTemplateObject:)
    @NSManaged public func addToGroupTemplate(_ value: FTExerciseGroupTemplate)

    @objc(removeGroupTemplateObject:)
    @NSManaged public func removeFromGroupTemplate(_ value: FTExerciseGroupTemplate)

    @objc(addGroupTemplate:)
    @NSManaged public func addToGroupTemplate(_ values: NSOrderedSet)

    @objc(removeGroupTemplate:)
    @NSManaged public func removeFromGroupTemplate(_ values: NSOrderedSet)

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
