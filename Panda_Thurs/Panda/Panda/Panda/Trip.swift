//
//  Trip.swift
//  Panda
//
//  Created by Neil Kulkarni on 4/25/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class Trip: NSObject {
    
    var id: Int
    var name: String
    var descripshun: String
    var location: String
    var api: String
    var userID: Int

    override init() {
        self.id = -1;
        self.name = "";
        self.descripshun = "";
        self.location = "";
        self.api = "";
        self.userID = -1;
    }
    
    func setTrip(id: Int, name: String, descripshun: String, location: String, api: String, userID: Int) {
        self.id = id;
        self.name = name;
        self.descripshun = descripshun;
        self.location = location;
        self.api = api;
        self.userID = userID;
    }

}
