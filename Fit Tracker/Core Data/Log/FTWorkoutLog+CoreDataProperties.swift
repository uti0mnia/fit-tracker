//
//  FTWorkoutLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTWorkoutLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTWorkoutLog> {
        return NSFetchRequest<FTWorkoutLog>(entityName: "FTWorkoutLog")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var workoutTemplate: FTWorkoutTemplate?

}
