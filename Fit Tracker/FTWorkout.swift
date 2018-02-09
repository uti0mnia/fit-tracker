//
//  Workout.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-29.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTWorkout: Object {
    @objc dynamic public var name = ""
    
    // Relationships
    public var exercises = List<FTWorkoutExercise>()
}
