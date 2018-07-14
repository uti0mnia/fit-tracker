//
//  FTExerciseTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTExerciseTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseTemplate> {
        return NSFetchRequest<FTExerciseTemplate>(entityName: "FTExerciseTemplate")
    }


}
