//
//  Exercise.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-01-29.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

@objc class FTExercise: Object  {
    public enum BodyPart: Int {
        case chest, back, shoulders, arms, abs, legs, none
    }

    public enum Category: Int {
        case barbell, dumbbell, machine, weighted, assisted, reps, cardio, duration, none
    }
    
    @objc dynamic public var name = ""
    @objc dynamic public var bodyPart = BodyPart.none.rawValue
    @objc dynamic public var category = Category.none.rawValue
    @objc dynamic public var restTime = 0
    @objc dynamic public var created = Date()
    
    // Relationships
    public var workoutExercise = List<FTWorkoutExercise>()
    public var workout = List<FTWorkout>()
    
    public func getBodyPart() -> BodyPart? {
        return BodyPart.init(rawValue: self.bodyPart)
    }
    
    public func getCategory() -> Category? {
        return Category.init(rawValue: self.category)
    }
    
    // TODO: Primary Key?
    // TODO: Indexing?
}

