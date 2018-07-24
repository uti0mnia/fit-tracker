//
//  FTExercise+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-24.
//
//

import Foundation
import CoreData


extension FTExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExercise> {
        return NSFetchRequest<FTExercise>(entityName: "FTExercise")
    }

    @NSManaged public var bodyPart: Int16
    @NSManaged public var category: Int16
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var isDefault: Bool
    @NSManaged public var isFavourite: Bool
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var restTime: Int16
    @NSManaged public var exerciseLogs: Set<FTExerciceLog>?
    @NSManaged public var exerciseTemplates: Set<FTExerciseTemplate>?
    @NSManaged public var options: FTExerciseOptions?

}

// MARK: Generated accessors for exerciseLogs
extension FTExercise {

    @objc(addExerciseLogsObject:)
    @NSManaged public func addToExerciseLogs(_ value: FTExerciseLog)

    @objc(removeExerciseLogsObject:)
    @NSManaged public func removeFromExerciseLogs(_ value: FTExerciseLog)

    @objc(addExerciseLogs:)
    @NSManaged public func addToExerciseLogs(_ values: NSSet)

    @objc(removeExerciseLogs:)
    @NSManaged public func removeFromExerciseLogs(_ values: NSSet)

}

// MARK: Generated accessors for exerciseTemplates
extension FTExercise {

    @objc(addExerciseTemplatesObject:)
    @NSManaged public func addToExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(removeExerciseTemplatesObject:)
    @NSManaged public func removeFromExerciseTemplates(_ value: FTExerciseTemplate)

    @objc(addExerciseTemplates:)
    @NSManaged public func addToExerciseTemplates(_ values: NSSet)

    @objc(removeExerciseTemplates:)
    @NSManaged public func removeFromExerciseTemplates(_ values: NSSet)

}
