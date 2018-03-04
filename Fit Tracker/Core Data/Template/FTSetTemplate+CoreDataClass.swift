//
//  FTSetTemplate+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
//
//

import Foundation
import CoreData

@objc(FTSetTemplate)
public class FTSetTemplate: NSManagedObject {

    @nonobjc public static func defaultSetTemplate(context: NSManagedObjectContext) -> FTSetTemplate {
        let set = FTSetTemplate(context: context)
        set.index = 0
        set.reps = -1
        set.weight = -1
        return set
    }
}
