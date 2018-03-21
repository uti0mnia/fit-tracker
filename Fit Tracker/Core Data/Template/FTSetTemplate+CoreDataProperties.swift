//
//  FTSetTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-20.
//
//

import Foundation
import CoreData


extension FTSetTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTSetTemplate> {
        return NSFetchRequest<FTSetTemplate>(entityName: "FTSetTemplate")
    }

    @NSManaged public var amount: NSObject?
    @NSManaged public var modifier: NSObject?
    @NSManaged public var exerciseTemplate: FTExerciseTemplate?

}
