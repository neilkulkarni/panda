//
//  User.swift
//  Panda
//
//  Created by Winnie Lin on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class User: NSObject {
    var id: Int
    var name: String
    var email: String
    var bio: String
    var picture: String
    
    override init() {
        self.id = -1;
        self.name = "";
        self.email = "";
        self.bio = "";
        self.picture = "";
    }
    
    func getID() -> Int {
        return self.id
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getBio() -> String {
        return self.bio
    }
    
    func getPicture() -> String {
        return self.picture
    }
   
    
    func setID(id: Int) {
        self.id = id
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func setBio(bio: String) {
        self.bio = bio
    }
    
    func setPicture(picture: String) {
        self.picture = picture
    }
       
    func setUser(id: Int, name: String, email: String, bio: String, picture: String) {
        self.id = id
        self.name = name
        self.email = email
        self.bio = bio
        self.picture = picture
       
        
    }
}
