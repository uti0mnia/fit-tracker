//
//  FTExerciseTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-21.
//
//

import Foundation
import CoreData


extension FTExerciseTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseTemplate> {
        return NSFetchRequest<FTExerciseTemplate>(entityName: "FTExerciseTemplate")
    }

    @NSManaged public var endRestTime: Int16
    @NSManaged public var index: Int16
    @NSManaged public var exercise: FTExercise?
    @NSManaged public var groupTemplate: FTExerciseGroupTemplate?
    @NSManaged public var setTemplates: Set<FTSetTemplate>?

}

// MARK: Generated accessors for setTemplates
extension FTExerciseTemplate {

    @objc(addSetTemplatesObject:)
    @NSManaged public func addToSetTemplates(_ value: FTSetTemplate)

    @objc(removeSetTemplatesObject:)
    @NSManaged public func removeFromSetTemplates(_ value: FTSetTemplate)

    @objc(addSetTemplates:)
    @NSManaged public func addToSetTemplates(_ values: NSSet)

    @objc(removeSetTemplates:)
    @NSManaged public func removeFromSetTemplates(_ values: NSSet)

}
