//
//  Business.swift
//  Panda
//
//  Created by Aarti Panda on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class Business: NSObject {
    var name:String?
    var rating:Double?
    var category:String?
    //time is not supported by the Yelp API
    var price:String?
    var url:String?
    var latitude:Double?
    var longitude:Double?
    //var apiRequestPath:String?
    var eventId = -1
    //name rating category time address price picture
}
