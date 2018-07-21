//
//  FTExercise+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
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
    @NSManaged public var options: FTExerciseOptions?
    @NSManaged public var abstractExercise: Set<FTAbstractExercise>?

}

// MARK: Generated accessors for abstractExercise
extension FTExercise {

    @objc(addAbstractExerciseObject:)
    @NSManaged public func addToAbstractExercise(_ value: FTAbstractExercise)

    @objc(removeAbstractExerciseObject:)
    @NSManaged public func removeFromAbstractExercise(_ value: FTAbstractExercise)

    @objc(addAbstractExercise:)
    @NSManaged public func addToAbstractExercise(_ values: NSSet)

    @objc(removeAbstractExercise:)
    @NSManaged public func removeFromAbstractExercise(_ values: NSSet)

}
