//
//  FTExerciseGroupTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTExerciseGroupTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTExerciseGroupTemplate> {
        return NSFetchRequest<FTExerciseGroupTemplate>(entityName: "FTExerciseGroupTemplate")
    }


}
