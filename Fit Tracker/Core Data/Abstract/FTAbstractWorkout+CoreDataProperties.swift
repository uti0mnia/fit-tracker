//
//  FTAbstractWorkout+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTAbstractWorkout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTAbstractWorkout> {
        return NSFetchRequest<FTAbstractWorkout>(entityName: "FTAbstractWorkout")
    }

    @NSManaged public var groups: NSSet?

}

// MARK: Generated accessors for groups
extension FTAbstractWorkout {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: FTAbstractGroup)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: FTAbstractGroup)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}
