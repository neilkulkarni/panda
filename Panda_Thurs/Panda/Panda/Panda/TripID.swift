//
//  tripID.swift
//  Panda
//
//  Created by Aaron Chang on 4/20/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Foundation
import Cocoa

class TripID: NSObject {
    var id: Int
    
    override init() {
        self.id = -1;
    }
    
    func getID() -> Int {
        return self.id
    }
    
    func setID(id: Int) {
        self.id = id
    }
}
