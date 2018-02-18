//
//  WorkoutLog.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTWorkoutLog: Object {
    
    @objc dynamic public var start = Date()
    @objc dynamic public var end = Date()
    
    // Relationship.
    public let exerciseLog = List<FTExerciseLog>()
    public let workoutTemplate = LinkingObjects(fromType: FTWorkoutTemplate.self, property: "workoutLogs")
}
