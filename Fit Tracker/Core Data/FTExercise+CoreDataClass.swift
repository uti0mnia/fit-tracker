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
        return name != nil && createdAt != nil
    }
    
    public var firstLetter: String {
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
    
    public enum Category: Int16, CustomStringConvertible {
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
}
