////
////  FTRealmFetchRequest.swift
////  Fit Tracker
////
////  Created by Casey McLewin on 2018-02-24.
////  Copyright © 2018 Casey McLewin. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//struct FTRealmFetchRequest {
//    
//    public let predicates: [NSPredicate]?                                   // predicate used to filter
//    
//    public let sortingProperties: [String]?                                 // properties to sort on (i.e. ["name"])
//    public var sortDesciptors: [SortDescriptor]? {                          // getter to allows sorted(by: ) to work in fetch controller
//        guard var properties = sortingProperties else {
//            return nil
//        }
//        if let property = sectionProperty {
//            properties.insert(property, at: 0)
//        }
//        
//        return properties.map({
//            return SortDescriptor(keyPath: $0)
//        })
//    }
//    public let sectionProperty: String?                                     // property for sections. Usually first value in sortingProperties
//    
//}

