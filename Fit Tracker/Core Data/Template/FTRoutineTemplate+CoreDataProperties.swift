//
//  FTRoutineTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-21.
//
//

import Foundation
import CoreData


extension FTRoutineTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTRoutineTemplate> {
        return NSFetchRequest<FTRoutineTemplate>(entityName: "FTRoutineTemplate")
    }

    @NSManaged public var name: String?
    @NSManaged public var workouts: Set<FTWorkoutTemplate>?

}

// MARK: Generated accessors for workouts
extension FTRoutineTemplate {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: FTWorkoutTemplate)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: FTWorkoutTemplate)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}
