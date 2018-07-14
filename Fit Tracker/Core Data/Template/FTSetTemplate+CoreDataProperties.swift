//
//  FTSetTemplate+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2018-07-13.
//
//

import Foundation
import CoreData


extension FTSetTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FTSetTemplate> {
        return NSFetchRequest<FTSetTemplate>(entityName: "FTSetTemplate")
    }


}
