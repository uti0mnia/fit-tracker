//
//  Workout.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-29.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTWorkoutExercise: Object {
    @objc dynamic public var reps = 0
    @objc dynamic public var sets = 0
    
    // Relationships
    public var exercise: FTExercise?
    
}
