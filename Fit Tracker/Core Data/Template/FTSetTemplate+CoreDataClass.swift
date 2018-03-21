//
//  FTSetTemplate+CoreDataClass.swift
//  
//
//  Created by Casey McLewin on 2018-03-01.
//
//

import Foundation
import CoreData

@objc(FTSetTemplate)
public class FTSetTemplate: NSManagedObject {
    
    /// Returns the amount that an exercise is done for. i.e TIME, REPS
    public var amountString: String {
        guard let category = self.exerciseCategory() else {
            return ""
        }
        
        switch category {
        case .assistedBodyweight, .barbell, .dumbbell, .machine, .repsOnly, .weightedBodyweight:
            return "Reps"
        case .cardio, .duration:
            return "Time"
        case .none:
            return "N/A"
        }
    }
    
    /// Returns the amount that an exercise is done for. i.e KM, +LBS, -LBS, LBS, N/A
    public var modifierString: String {
        guard let category = self.exerciseCategory() else {
            return ""
        }
        
        switch category {
        case .assistedBodyweight :
            return "(+\(FTSettingsManager.shared.preferredWeight.string)"
        case .barbell, .dumbbell, .machine:
            return FTSettingsManager.shared.preferredWeight.string
        case .cardio:
            return FTSettingsManager.shared.preferredDistance.string
        case .duration, .repsOnly, .none:
            return "N/A"
        case .weightedBodyweight:
            return "(-\(FTSettingsManager.shared.preferredWeight.string))"
        }
    }
    
    private func exerciseBodyPart() -> FTExercise.BodyPart? {
        return self.exerciseTemplate?.exercise?.getBodyPart()
    }
    
    private func exerciseCategory() -> FTExercise.Category? {
        return self.exerciseTemplate?.exercise?.getCategory()
    }
}
