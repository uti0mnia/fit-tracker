//
//  FTExerciseGroupLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTExerciseGroupLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseGroupLog> {
        return NSFetchRequest<FTExerciseGroupLog>(entityName: "FTExerciseGroupLog")
    }


}
