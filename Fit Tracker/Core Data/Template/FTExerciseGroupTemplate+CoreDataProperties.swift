//
//  FTExerciseGroupTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
//
//

import Foundation
import CoreData


extension FTExerciseGroupTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseGroupTemplate> {
        return NSFetchRequest<FTExerciseGroupTemplate>(entityName: "FTExerciseGroupTemplate")
    }

    @NSManaged public var exerciseTemplates: NSOrderedSet?
    @NSManaged public var workoutTemplate: FTWorkoutTemplate?

}

// MARK: Generated accessors for exerciseTemplates
extension FTExerciseGroupTemplate {

    @objc(insertObject:inExerciseTemplatesAtIndex:)
    @NSManaged public func insertIntoExerciseTemplates(_ value: FTExerciseTemplate, at idx: Int)

    @objc(removeObjectFromExerciseTemplatesAtIndex:)
    @NSManaged public func removeFromExerciseTemplates(at idx: Int)

    @objc(insertExerciseTemplates:atIndexes:)
    @NSManaged public func insertIntoExerciseTemplates(_ values: [FTExerciseTemplate], at indexes: NSIndexSet)

    @objc(removeExerciseTemplatesAtIndexes:)
    @NSManaged public func removeFromExerciseTemplates(at indexes: NSIndexSet)

    @objc(replaceObjectInExerciseTemplatesAtIndex:withObject:)
    @NSManaged public func replaceExerciseTemplates(at idx: Int, with value: FTExerciseTemplate)

    @objc(replaceExerciseTemplatesAtIndexes:withExerciseTemplates:)
    @NSManaged public func replaceExerciseTemplates(at indexes: NSIndexSet, with values: [FTExerciseTemplate])

    @objc(addExerciseTemplatesObject:)
    @NSManaged public func addToExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(removeExerciseTemplatesObject:)
    @NSManaged public func removeFromExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(addExerciseTemplates:)
    @NSManaged public func addToExerciseTemplates(_ values: NSOrderedSet)

    @objc(removeExerciseTemplates:)
    @NSManaged public func removeFromExerciseTemplates(_ values: NSOrderedSet)

}
