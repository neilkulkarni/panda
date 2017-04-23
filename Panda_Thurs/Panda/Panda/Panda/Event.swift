//
//  Event.swift
//  Panda
//
//  Created by Neil Kulkarni on 4/22/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class Event: NSObject {
    var id: Int
    var name: String
    var descripshun: String
    
    var picture1: String
    var picture2: String
    var picture3: String
    var picture4: String
    
    var latitude: String
    var longitude: String
    
    var date: String
   
    var api: String
    
    var tripID: Int
    
    var order: Int
    
    override init() {
        self.id = -1;
        self.name = "";
        self.descripshun = "";
        
        self.picture1 = "";
        self.picture2 = "";
        self.picture3 = "";
        self.picture4 = "";
        
        self.latitude = "";
        self.longitude = "";
        
        self.date = "";
        
        self.api = "";
        
        self.tripID = -1;
        
        self.order = -1;
    }
    
    func setEvent(id: Int, name: String, descripshun: String, picture1: String, picture2: String, picture3: String, picture4: String,
                  latitude: String, longitude: String, date: String, api: String, tripID: Int, order: Int) {
        self.id = id;
        self.name = name;
        self.descripshun = descripshun;
        
        self.picture1 = picture1;
        self.picture2 = picture2;
        self.picture3 = picture3;
        self.picture4 = picture4;
        
        self.latitude = latitude;
        self.longitude = longitude;
        
        self.date = date;
        
        self.api = api;
        
        self.tripID = tripID;
        
        self.order = order;
    }
    
    func getName() -> String {
        return self.name
    }
}
