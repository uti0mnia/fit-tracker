//
//  FTRealmManager.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-30.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTRealmManager {
    typealias FTCommitBlock = (Bool, Error?) -> Void
    
    private var exercises = [FTExercise]()
    private var workoutExercises = [FTWorkoutExercise]()
    private var workouts = [FTWorkout]()
    
    private let writeQueue = DispatchQueue(label: "FTRealmManager.writeQueue")
    
    public func addExercise(name: String, bodyPart: FTExercise.BodyPart, category: FTExercise.Category, restTime: Int, created: Date = Date()) {
        let exercise = FTExercise()
        exercise.name = name
        exercise.bodyPart = bodyPart.rawValue
        exercise.category = category.rawValue
        exercise.restTime = restTime
        exercise.created = created
        
        exercises.append(exercise)
    }
    
    public func addWorkoutExercise(exercise: FTExercise, reps: Int, sets: Int) {
        let workoutExercise = FTWorkoutExercise()
        workoutExercise.exercise = exercise
        workoutExercise.reps = reps
        workoutExercise.sets = sets
        
        workoutExercises.append(workoutExercise)
    }
    
    public func addWorkout(name: String, exercises: List<FTWorkoutExercise>) {
        let workout = FTWorkout()
        workout.name = name
        workout.exercises = exercises
        
        workouts.append(workout)
    }
    
    public func commit(completion: @escaping FTCommitBlock) {
        writeQueue.async {
            do {
                let realm = try Realm()
                try realm.write {
                    self.exercises.forEach({ realm.add($0) })
                    self.workoutExercises.forEach({ realm.add($0) })
                    self.workouts.forEach({ realm.add($0) })
                }
                completion(true, nil)
                
                self.exercises.removeAll()
                self.workoutExercises.removeAll()
                self.workoutExercises.removeAll()
                
            } catch {
                print("error writting object to realm: \(error.localizedDescription)")
                completion(false, error)
            }
        }
    }
    
}
