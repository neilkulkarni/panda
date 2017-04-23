//
//  Business.swift
//  Panda
//
//  Created by Aarti Panda on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class Business: NSObject {
    var image:NSImage?
    var name:String?
    var rating:Double?
    var category:String?
    var location:String?
    //time is not supported by the Yelp API
    var price:String?
    var url:String?
    var latitude:String?
    var longitude:String?
    //var apiRequestPath:String?
    var eventId = -1
    //name rating category time address price picture
    var address:String?
}
