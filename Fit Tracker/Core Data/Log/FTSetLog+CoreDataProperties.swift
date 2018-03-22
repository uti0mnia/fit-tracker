//
//  FTSetLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-03-21.
//
//

import Foundation
import CoreData


extension FTSetLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTSetLog> {
        return NSFetchRequest<FTSetLog>(entityName: "FTSetLog")
    }

    @NSManaged public var amount: NSObject?
    @NSManaged public var modifier: NSObject?
    @NSManaged public var index: Int16
    @NSManaged public var exerciseLog: FTExerciseLog?

}
