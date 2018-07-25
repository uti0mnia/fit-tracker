 //
//  FTEditWorkoutViewModel.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-07-24.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import CoreData

struct FTEditWorkoutTemplateViewModel: FTEditWorkoutModelProtocol {
    
    public let workout: FTWorkoutTemplate
    private let context: NSManagedObjectContext?
    
    private let isNew: Bool
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.workout = NSEntityDescription.insertNewObject(forEntityName: String(describing: FTWorkoutTemplate.self), into: context) as! FTWorkoutTemplate
        self.isNew = true
    }
    
    init(workout: FTWorkoutTemplate) {
        self.workout = workout
        self.context = workout.managedObjectContext
        self.isNew = false
    }
    
    // MARK: - FTEditWorkoutProtocol
    
    var workoutName: String? {
        get {
            return workout.name
        }
        set {
            workout.name = newValue
        }
    }
    
    var exerciseCount: Int {
        return workout.exerciseCount
    }
    
    func applyChanges() {
        guard let context = self.context else {
            assertionFailure("Workout should have a managed object context")
            return
        }
        
        if isNew && exerciseCount == 0 {
            context.delete(workout)
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO: Handle gracefully
                assertionFailure("Error saving to context")
            }
        }
    }
    
    
    
}
