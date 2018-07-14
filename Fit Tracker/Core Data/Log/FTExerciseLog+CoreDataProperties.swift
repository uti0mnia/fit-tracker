//
//  FTExerciseLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTExerciseLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseLog> {
        return NSFetchRequest<FTExerciseLog>(entityName: "FTExerciseLog")
    }

    @NSManaged public var date: NSDate?

}
