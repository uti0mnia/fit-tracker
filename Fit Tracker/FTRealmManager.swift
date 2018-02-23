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
    
    private let backgroundQueue = DispatchQueue(label: "FTRealmManager.backgroundQueue")
    
}
