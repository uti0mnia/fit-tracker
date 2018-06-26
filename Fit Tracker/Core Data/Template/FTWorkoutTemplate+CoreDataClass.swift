//
//  FTWorkoutTemplate+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
//
//

import Foundation
import CoreData

@objc(FTWorkoutTemplate)
public class FTWorkoutTemplate: NSManagedObject {
    public var exerciseCount: Int {
        var count = 0
        for group in groupTemplates ?? [] {
            count += group.exerciseTemplates?.count ?? 0
        }
        return count
    }
}
