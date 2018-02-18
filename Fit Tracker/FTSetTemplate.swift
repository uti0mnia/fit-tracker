//
//  File.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

class FTSetTemplate: Object {
    
    @objc dynamic var weight: Double = 0
    @objc dynamic var reps = 0
    
    public let exerciseTemplate = LinkingObjects(fromType: FTExerciseTemplate.self, property: "setTemplates")
}

