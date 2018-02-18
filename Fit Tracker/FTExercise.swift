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
    public enum BodyPart: Int, CustomStringConvertible {
        case abs, arms, back, chest, legs, shoulders, none
        
        public var description: String {
            switch self {
            case .abs:
                return "Abs"
            case .arms:
                return "Arms"
            case .back:
                return "Back"
            case .chest:
                return "Chest"
            case .legs:
                return "Legs"
            case .shoulders:
                return "Shoulders"
            case .none:
                return "None"
            }
        }
        
        public static var array: [BodyPart] {
            return [.abs, .arms, .back, .chest, .legs, .shoulders, .none]
        }
    }

    public enum Category: Int, CustomStringConvertible {
        case assisted, barbell, cardio, dumbbell, duration, machine, other, reps, weighted, none
        
        public var description: String {
            switch self {
            case .assisted:
                return "Assisted"
            case .barbell:
                return "Barbell"
            case .cardio:
                return "Cardio"
            case .dumbbell:
                return "Dumbbell"
            case .duration:
                return "Duration"
            case .machine:
                return "Machine"
            case .other:
                return "Other"
            case .reps:
                return "Reps"
            case .weighted:
                return "Weighted"
            case .none:
                return "None"
            }
        }
        
        public static var array: [Category] {
            return [.assisted, .barbell, .cardio, .dumbbell, .duration, .machine, .other, .reps, .weighted, .none]
        }
    }
    
    @objc dynamic public var name = ""
    @objc dynamic public var bodyPart = BodyPart.none.rawValue
    @objc dynamic public var category = Category.none.rawValue
    @objc dynamic public var restTime = 0
    
    // Relationships
    public var exerciseLogs = LinkingObjects(fromType: FTExerciseLog.self, property: "exercise")
    public let exerciseTemplates = LinkingObjects(fromType: FTExerciseTemplate.self, property: "exercise")
    
    public func getBodyPart() -> BodyPart? {
        return BodyPart.init(rawValue: self.bodyPart)
    }
    
    public func getCategory() -> Category? {
        return Category.init(rawValue: self.category)
    }
    
    // TODO: Primary Key?
    // TODO: Indexing?
}

