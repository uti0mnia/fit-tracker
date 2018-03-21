//
//  FTExerciseTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
//
//

import Foundation
import CoreData


extension FTExerciseTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseTemplate> {
        return NSFetchRequest<FTExerciseTemplate>(entityName: "FTExerciseTemplate")
    }

    @NSManaged public var endRestTime: Int16
    @NSManaged public var exercise: FTExercise?
    @NSManaged public var groupTemplate: FTExerciseGroupTemplate?
    @NSManaged public var setTemplates: NSOrderedSet?

}

// MARK: Generated accessors for setTemplates
extension FTExerciseTemplate {

    @objc(insertObject:inSetTemplatesAtIndex:)
    @NSManaged public func insertIntoSetTemplates(_ value: FTSetTemplate, at idx: Int)

    @objc(removeObjectFromSetTemplatesAtIndex:)
    @NSManaged public func removeFromSetTemplates(at idx: Int)

    @objc(insertSetTemplates:atIndexes:)
    @NSManaged public func insertIntoSetTemplates(_ values: [FTSetTemplate], at indexes: NSIndexSet)

    @objc(removeSetTemplatesAtIndexes:)
    @NSManaged public func removeFromSetTemplates(at indexes: NSIndexSet)

    @objc(replaceObjectInSetTemplatesAtIndex:withObject:)
    @NSManaged public func replaceSetTemplates(at idx: Int, with value: FTSetTemplate)

    @objc(replaceSetTemplatesAtIndexes:withSetTemplates:)
    @NSManaged public func replaceSetTemplates(at indexes: NSIndexSet, with values: [FTSetTemplate])

    @objc(addSetTemplatesObject:)
    @NSManaged public func addToSetTemplates(_ value: FTSetTemplate)

    @objc(removeSetTemplatesObject:)
    @NSManaged public func removeFromSetTemplates(_ value: FTSetTemplate)

    @objc(addSetTemplates:)
    @NSManaged public func addToSetTemplates(_ values: NSOrderedSet)

    @objc(removeSetTemplates:)
    @NSManaged public func removeFromSetTemplates(_ values: NSOrderedSet)

}
