//
//  FTSetTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-24.
//
//

import Foundation
import CoreData


extension FTSetTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTSetTemplate> {
        return NSFetchRequest<FTSetTemplate>(entityName: "FTSetTemplate")
    }

    @NSManaged public var amount: NSObject?
    @NSManaged public var index: Int16
    @NSManaged public var modifier: NSObject?
    @NSManaged public var exerciseTemplate: FTExerciseTemplate?

}
