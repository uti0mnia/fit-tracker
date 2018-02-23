//
//  FTExerciseLog.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTExerciseLog: Object {
    
    @objc dynamic public var date = Date()
    
    // Relationships.
    @objc dynamic var exercise: FTExercise?
    public let setLogs = List<FTSetLog>()
    
    public var workoutLog = LinkingObjects(fromType: FTWorkoutLog.self, property: "exerciseLog")
    
    convenience init(date: Date, exercise: FTExercise) {
        self.init()
        
        self.date = date
        self.exercise = exercise
    }
    
}
