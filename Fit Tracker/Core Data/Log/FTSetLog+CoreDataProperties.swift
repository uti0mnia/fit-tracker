//
//  FTSetLog+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTSetLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTSetLog> {
        return NSFetchRequest<FTSetLog>(entityName: "FTSetLog")
    }


}
