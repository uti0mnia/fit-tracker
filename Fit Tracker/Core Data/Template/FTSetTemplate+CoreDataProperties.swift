//
//  FTSetTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
//
//

import Foundation
import CoreData


extension FTSetTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTSetTemplate> {
        return NSFetchRequest<FTSetTemplate>(entityName: "FTSetTemplate")
    }

    @NSManaged public var reps: Int16
    @NSManaged public var weight: Double
    @NSManaged public var index: Int16
    @NSManaged public var exerciseTemplate: FTExerciseTemplate?

}
