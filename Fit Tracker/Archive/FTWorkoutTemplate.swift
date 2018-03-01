//
//  Workout.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-29.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTWorkoutTemplate: Object {
    @objc dynamic public var name = ""
    @objc dynamic public var isDefault = false // For included workouts.
    
    // Relationships
    public var workoutLogs = List<FTWorkoutLog>()
    public var exercises = List<FTExerciseTemplate>()
    
    convenience init(name: String, isDefault: Bool) {
        self.init()
        
        self.name = name
        self.isDefault = isDefault
    }
}
