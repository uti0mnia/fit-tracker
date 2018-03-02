//
//  FTExercise+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
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
    @NSManaged public var name: String?
    @NSManaged public var restTime: Int16
    @NSManaged public var exerciseLogs: Set<FTExerciseLog>?
    @NSManaged public var exerciseTemplate: Set<FTExerciseTemplate>?

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

// MARK: Generated accessors for exerciseTemplate
extension FTExercise {

    @objc(addExerciseTemplateObject:)
    @NSManaged public func addToExerciseTemplate(_ value: FTExerciseTemplate)

    @objc(removeExerciseTemplateObject:)
    @NSManaged public func removeFromExerciseTemplate(_ value: FTExerciseTemplate)

    @objc(addExerciseTemplate:)
    @NSManaged public func addToExerciseTemplate(_ values: NSSet)

    @objc(removeExerciseTemplate:)
    @NSManaged public func removeFromExerciseTemplate(_ values: NSSet)

}
