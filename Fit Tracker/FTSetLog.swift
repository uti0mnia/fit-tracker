//
//  FTSetLog.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTSetLog: Object {
    
    @objc dynamic public var weight: Double = 0
    @objc dynamic public var reps = 0
    
    public let exerciseLog = LinkingObjects(fromType: FTExerciseLog.self, property: "setLogs")
    
    convenience init(weight: Double, reps: Int) {
        self.init()
        
        self.weight = weight
        self.reps = reps
    }
}
