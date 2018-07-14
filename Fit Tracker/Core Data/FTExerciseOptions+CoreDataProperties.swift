//
//  FTExerciseOptions+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTExerciseOptions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseOptions> {
        return NSFetchRequest<FTExerciseOptions>(entityName: "FTExerciseOptions")
    }

    @NSManaged public var autoIncreaseAmount: Double
    @NSManaged public var isAutoIncreaseEnabled: Bool
    @NSManaged public var exercise: FTExercise?

}
