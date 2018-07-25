//
//  FTEditWorkoutViewModel.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-07-24.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation

struct FTEditWorkoutTemplateViewModel: FTEditWorkoutModelProtocol {
    
    public let workout: FTWorkoutTemplate
    
    init(workout: FTWorkoutTemplate) {
        self.workout = workout
    }
    
    // MARK: - FTEditWorkoutProtocol
    
    var workoutName: String {
        get {
            return workout.name ?? ""
        }
        set {
            workout.name = newValue
        }
    }
    
    var exerciseCount: Int {
        return workout.exerciseCount
    }
    
}
