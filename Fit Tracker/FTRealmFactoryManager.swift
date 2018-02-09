//
//  FTRealmFactory.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-30.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTRealmFactoryManager {
    
    public static let shared = FTRealmFactoryManager()
    
    private init() {}
    
    public func createExercise(name: String, bodyPart: FTExercise.BodyPart, category: FTExercise.Category, restTime: Int, created: Date = Date()) -> FTExercise {
        let exercise = FTExercise()
        
        exercise.name = name
        exercise.bodyPart = bodyPart.rawValue
        exercise.category = category.rawValue
        exercise.restTime = restTime
        exercise.created = created
        
        return exercise
    }
    
    public func createWorkoutExercise(exercise: FTExercise, reps: Int, sets: Int) -> FTWorkoutExercise {
        let workoutExercise = FTWorkoutExercise()
        
        workoutExercise.exercise = exercise
        workoutExercise.reps = reps
        workoutExercise.sets = sets
        
        return workoutExercise
    }
    
    public func createWorkout(name: String, exercises: List<FTWorkoutExercise>) -> FTWorkout {
        let workout = FTWorkout()
        
        workout.name = name
        workout.exercises = exercises
        
        return workout
    }
    
}
