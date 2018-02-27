//
//  FTRealmExetension.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-02-17.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import Foundation
import RealmSwift

extension List {
    public func ft_forEach(block: (Element) -> Void) {
        var iterator = self.makeIterator()
        var el = iterator.next()
        while (el != nil) {
            block(el!)
            el = iterator.next()
        }
    }
    
    public func ft_joined(separator: String) -> String {
        var str = ""
        for i in 0..<self.count {
            str += (i == 0) ? "\(self[i])" : "\(separator)\(self[i])"
        }
        return str
    }
}

extension Results {
    public func ft_safeAccess(at idx: Int) -> Element? {
        guard idx >= 0, idx < count else {
            return nil
        }
        
        return self[idx]
    }
}
