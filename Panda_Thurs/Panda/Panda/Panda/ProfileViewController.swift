//
//  ProfileViewController.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/3/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import WebKit

class ProfileViewController: NSViewController {
    var trip_id: TripID = TripID()
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var bioField: NSTextField!
    @IBOutlet weak var pictureField: NSTextField!
    @IBOutlet weak var newBio: NSTextField!
    @IBOutlet weak var bioErrorLabel: NSTextField!
    @IBOutlet weak var mapWebView: WebView!
    
    @IBOutlet weak var mostRecentTripName: NSTextField!
    @IBOutlet weak var profilePictureView: NSImageView!
    
    @IBOutlet weak var pictureUpperLeft: NSButton!
    @IBOutlet weak var pictureUpperRight: NSButton!
    
    @IBOutlet weak var pictureLowerLeft: NSButton!
    
    @IBOutlet weak var pictureLowerRight: NSButton!
    
    var user: User = User()
    var id:Int?
    var bio:String?
    var picture:String?
    
    
    var eventList: [Event] = []
    var picList: [String] = []
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 255/255.0, green: 220/255.0, blue: 200/255.0, alpha: 0.5)
        
        nameField.stringValue = user.getName()
        emailField.stringValue = user.getEmail()
        newBio.stringValue = user.getBio()

    if(user.getPicture() != "") {
            var urlStr = URL(string: user.getPicture())
            profilePictureView.image = NSImage(contentsOf: urlStr!)
        }
        else {
            print("hi")
            profilePictureView.image = #imageLiteral(resourceName: "pandaicon2.png")
        }
      

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        profilePictureView.image = NSImage(byReferencingFile: user.getPicture())
        let request = "http://localhost:8081/most-recent-trip/" + "\(user.getID())"
        Alamofire.request(request).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            guard let info = response.result.value else {
                print("Error")
                return
            }
            
            let json = JSON(info)
            print(json)
            self.trip_id.setID(id: json["trip"]["id"].int!)
            self.mostRecentTripName.stringValue = json["trip"]["name"].stringValue
            let requesturl = URL(string: json["trip"]["api"].stringValue)
            let request = URLRequest(url: requesturl!)
            self.mapWebView.mainFrame.load(request)
           // let eventResults = json["trip"]["eventList"].arrayValue
            
            let eventRequest = "http://localhost:8081/events/" + "\(self.trip_id.getID())"
            Alamofire.request(eventRequest).responseJSON { response in
                
                guard let info = response.result.value
                    else {
                    print("Error")
                    return
                }
                
                let eventJSON = JSON(info)
                print(eventJSON)
                
                let eventResults = eventJSON["eventList"].arrayValue
                
                
                self.eventList.removeAll()
                
                for i in 0...(eventResults.count-1) {
                    self.eventList.append(self.convertToEvent(result: eventResults[i]))
                }

                
                var count = 0
                self.picList.removeAll()
                
                 for i in 0...(eventResults.count-1) {
                    
                    if(count == 4) {
                        break
                    }
                    if((eventResults[i]["picture1"] != "") && (!self.picList.contains(eventResults[i]["picture1"].stringValue))){
                        
                        
                        self.picList.append(eventResults[i]["picture1"].stringValue)
                        count += 1
                        
                        }
                    if((eventResults[i]["picture2"] != "") && (!self.picList.contains(eventResults[i]["picture2"].stringValue)) ){
                        
                        
                        self.picList.append(eventResults[i]["picture2"].stringValue)
                        count += 1
                    }
                        
                    if((eventResults[i]["picture3"] != "") && (!self.picList.contains(eventResults[i]["picture3"].stringValue))){
                        self.picList.append(eventResults[i]["picture3"].stringValue)
                        count += 1
                        
                        
                    }
                    if((eventResults[i]["picture4"] != "") && (!self.picList.contains(eventResults[i]["picture4"].stringValue))){
                        self.picList.append(eventResults[i]["picture4"].stringValue)
                        count += 1
                        
                }
                    
                    
                    
                    
                   
            }
                if(count == 1) {
                    var urlStr = URL(string: self.picList[0])
                    self.pictureUpperLeft.image = NSImage(contentsOf: urlStr!)
                }
                else if(count == 2){
                    var urlStr = URL(string: self.picList[0])
                    self.pictureUpperLeft.image = NSImage(contentsOf: urlStr!)
                        urlStr = URL(string: self.picList[1])
                    self.pictureUpperRight.image = NSImage(contentsOf: urlStr!)

                }
                else if(count == 3) {
                    var urlStr = URL(string: self.picList[0])
                    self.pictureUpperLeft.image = NSImage(contentsOf: urlStr!)
                    
                    urlStr = URL(string: self.picList[1])
                    self.pictureUpperRight.image = NSImage(contentsOf: urlStr!)
                    
                    urlStr = URL(string:  self.picList[2])
                    
                    self.pictureLowerLeft.image = NSImage(contentsOf: urlStr!)
                    
                }
                else if(count == 4){
                    var urlStr = URL(string: self.picList[0])
                    self.pictureUpperLeft.image = NSImage(contentsOf: urlStr!)
                    
                    urlStr = URL(string: self.picList[1])
                    self.pictureUpperRight.image = NSImage(contentsOf: urlStr!)
                    
                    urlStr = URL(string:  self.picList[2])
                    self.pictureLowerLeft.image = NSImage(contentsOf: urlStr!)
                    
                    urlStr = URL(string: self.picList[3])
                    self.pictureLowerRight.image = NSImage(contentsOf: urlStr!)
                }
                print("list")
                for i in 0 ... (self.picList.count - 1) {
                print (self.picList[i])
                }
                
            }
           
        }
        
           }

    @IBAction func editBio(_ sender: Any) {
        if (newBio.stringValue.characters.count > 160) {
            bioErrorLabel.isHidden = false
            return
        }
        else {
            bioErrorLabel.isHidden = true
        }
        bio = newBio.stringValue
        //id = user.getID()
        let parameters: Parameters = [
            "id": user.getID(),
            "bio": bio!,
            "picture": user.getPicture()
        ]
        
        //var isSuccessful = false
        
        Alamofire.request("http://localhost:8081/user", method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if response.result.isSuccess {
                guard let info = response.result.value else {
                    print("Error")
                    return
                }
                
                let json = JSON(info)
            }
        }
        user.setBio(bio: newBio.stringValue)
    }
    
    func convertToEvent(result: JSON) -> Event {
        let event: Event = Event()
        
        event.setEvent(id: result["id"].intValue, name: result["name"].stringValue, descripshun: result["description"].stringValue, picture1: result["picture1"].stringValue, picture2: result["picture2"].stringValue, picture3: result["picture3"].stringValue, picture4: result["picture4"].stringValue, latitude: result["latitude"].stringValue, longitude: result["longitude"].stringValue, date: result["date"].stringValue, api: result["api"].stringValue, tripID: result["trip_id"].intValue, order: result["order"].intValue)
        
        return event
    }

    @IBAction func homeButton(_ sender: Any) {
         performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
     performSegue(withIdentifier: "idSegue", sender: self)
    }
    @IBAction func editProfileButton(_ sender: Any) {
        let imagePicker: NSOpenPanel = NSOpenPanel()
        imagePicker.allowsMultipleSelection = false
        imagePicker.canChooseFiles = true
        imagePicker.canChooseDirectories = false
        
        imagePicker.runModal()
        var imageChosen = imagePicker.url
       // print(imagePicker.url)
        if(imageChosen != nil ){
            var image = NSImage(contentsOf: imageChosen!)
         // user.setPicture(picture: imageChosen!.absoluteString)
            profilePictureView.image = image
            user.setPicture(picture: imageChosen!.absoluteString)
            

            
            let parameters: Parameters = [
                "id": user.getID(),
                "bio": user.getBio(),
                "picture": user.getPicture()

            ]

            
            Alamofire.request("http://localhost:8081/user", method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if response.result.isSuccess {
                    guard let info = response.result.value else {
                        print("Error")
                        return
                    }
                    

                    let json = JSON(info)
                }
            }

           user.setPicture(picture: imageChosen!.absoluteString)
            
            
            
            
          

        }
        
            
            
          
            
    }
  
    @IBAction func mapOverview(_ sender: Any) {
    }
  
    @IBAction func clickMap(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToTrip", sender: self)
    }
    
    @IBAction func clickPictureUpperLeft(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToTrip", sender: self)
    }
    @IBAction func clickPictureUpperRight(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToTrip", sender: self)
    }
    @IBAction func clickPictureLowerLeft(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToTrip", sender: self)
    }
    @IBAction func clickPictureLowerRight(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToTrip", sender: self)
    }
    @IBAction func clickDescription(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToTrip", sender: self)
    }
  
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToHome") {
            if let destination = segue.destinationController as? HomepageViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        else if (segue.identifier == "idSegueToTrip") {
            if let destination = segue.destinationController as? TripViewController {
                destination.trip_id.setID(id: trip_id.getID())
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
    }
}
