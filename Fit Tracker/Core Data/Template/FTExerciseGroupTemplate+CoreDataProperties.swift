//
//  FTExerciseGroupTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-03.
//
//

import Foundation
import CoreData


extension FTExerciseGroupTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseGroupTemplate> {
        return NSFetchRequest<FTExerciseGroupTemplate>(entityName: "FTExerciseGroupTemplate")
    }

    @NSManaged public var index: Int16
    @NSManaged public var exerciseTemplates: Set<FTExerciseTemplate>?
    @NSManaged public var workoutLog: FTWorkoutLog?

}

// MARK: Generated accessors for exerciseTemplates
extension FTExerciseGroupTemplate {

    @objc(addExerciseTemplatesObject:)
    @NSManaged public func addToExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(removeExerciseTemplatesObject:)
    @NSManaged public func removeFromExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(addExerciseTemplates:)
    @NSManaged public func addToExerciseTemplates(_ values: NSSet)

    @objc(removeExerciseTemplates:)
    @NSManaged public func removeFromExerciseTemplates(_ values: NSSet)

}
