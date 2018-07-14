//
//  FTAbstractSet+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTAbstractSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTAbstractSet> {
        return NSFetchRequest<FTAbstractSet>(entityName: "FTAbstractSet")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var index: Int16
    @NSManaged public var modifier: NSObject?
    @NSManaged public var exercise: FTAbstractExercise?

}
