//
//  ExerciseTemplate.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTExerciseTemplate: Object {
    
    @objc dynamic public var exercise: FTExercise?
    
    public let setTemplates = List<FTSetTemplate>()
    public let workoutTemplates = LinkingObjects(fromType: FTWorkoutTemplate.self, property: "exercises")
}
