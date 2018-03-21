//
//  FTExercise+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
//
//

import Foundation
import CoreData

@objc(FTExercise)
public class FTExercise: NSManagedObject {
    
    public var isComplete: Bool {
        return name != nil && createdAt != nil && category != Category.none.rawValue && bodyPart != BodyPart.none.rawValue
    }
    
    @objc public var firstLetter: String {
        self.willAccessValue(forKey: "firstLetter")
        let firstLetter = self.name?[0] ?? ""
        self.didAccessValue(forKey: "firstLetter")
        return firstLetter
    }
    
    public func getBodyPart() -> BodyPart {
        return BodyPart.init(rawValue: self.bodyPart) ?? .none
    }
    
    public func getCategory() -> Category {
        return Category.init(rawValue: self.category) ?? .none
    }
    
    public enum BodyPart: Int16, CustomStringConvertible {
        case arms, back, cardio, chest, core, fullBody, legs, olympic, shoulders, none = -1
        
        public var description: String {
            switch self {
            case .arms:
                return "Arms"
            case .back:
                return "Back"
            case .cardio:
                return "Cardio"
            case .chest:
                return "Chest"
            case .core:
                return "Core"
            case .fullBody:
                return "Full Body"
            case .legs:
                return "Legs"
            case .olympic:
                return "Olympic"
            case .shoulders:
                return "Shoulders"
            case .none:
                return "None"
            }
        }
        
        public static var array: [BodyPart] {
            return [.arms, .back, .cardio, .chest, .core, .fullBody, .legs, .olympic, .shoulders]
        }
    }
    
    public enum Category: Int16, CustomStringConvertible {
        case assistedBodyweight, barbell, cardio, dumbbell, duration, machine, repsOnly, weightedBodyweight, none = -1
        
        public var description: String {
            switch self {
            case .assistedBodyweight:
                return "Assisted Bodyweight"
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
            case .repsOnly:
                return "Reps Only"
            case .weightedBodyweight:
                return "Weighted Bodyweight"
            case .none:
                return "None"
            }
        }
        
        public static var array: [Category] {
            return [.assistedBodyweight, .barbell, .cardio, .dumbbell, .duration, .machine, .repsOnly, .weightedBodyweight]
        }
    }
}
