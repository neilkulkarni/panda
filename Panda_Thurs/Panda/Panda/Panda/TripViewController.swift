//
//  TripViewController.swift
//  Panda
//
//  Created by Winnie Lin on 4/5/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import MapKit
import WebKit

class TripViewController: NSViewController {
    var user: User = User()
    var trip_id: Int = -1

    @IBOutlet weak var tripNameField: NSTextField!
    @IBOutlet weak var tripDescLabel: NSTextField!
    @IBOutlet weak var mapWebView: WebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let tripParams: Parameters = [
            "trip_id": trip_id
        ]
        
        Alamofire.request("http://localhost:8081/trip/:id", method: .get, parameters: tripParams, encoding: JSONEncoding.default).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            guard let info = response.result.value else {
                print("Error")
                return
            }
            
            let tripJSON = JSON(info)
            print(tripJSON)
            self.tripNameField.stringValue = tripJSON["name"].stringValue
            self.tripDescLabel.stringValue = tripJSON["description"].stringValue
            let requesturl = URL(string: tripJSON["api"].stringValue)
            let request = URLRequest(url: requesturl!)
            self.mapWebView.mainFrame.load(request)
        }
        
    }
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 220/255.0, blue: 255/255.0, alpha: 0.5)
    }
    
    @IBAction func homeButton(_ sender: Any) {
         performSegue(withIdentifier: "idSegue", sender: self)
    }
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    @IBOutlet weak var pictureUpperLeft: NSImageView!
    @IBOutlet weak var pictureUpperRight: NSImageView!
    @IBOutlet weak var pictureLowerLeft: NSImageView!
    @IBOutlet weak var pictureLowerRight: NSImageView!
    
    @IBOutlet weak var addButtonUpperLeft: NSButton!
    @IBOutlet weak var addButtonUpperRight: NSButton!
    @IBOutlet weak var addButtonLowerLeft: NSButton!
    
    @IBOutlet weak var addButtonLowerRight: NSButton!

    @IBAction func addPhoto1(_ sender: Any) {
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
            //profilePictureView.image = image
            pictureUpperLeft.image = image;
          //  user.setPicture(picture: imageChosen!.absoluteString)
            
        }
    }
    
    @IBAction func addPhoto2(_ sender: Any) {
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
            //profilePictureView.image = image
            pictureUpperRight.image = image;
            //  user.setPicture(picture: imageChosen!.absoluteString)
            
        }

    }
    @IBAction func addPhoto3(_ sender: Any) {
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
            //profilePictureView.image = image
            pictureLowerLeft.image = image;
            //  user.setPicture(picture: imageChosen!.absoluteString)
            
        }

    }
   
    @IBAction func addPhoto4(_ sender: Any) {
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
            //profilePictureView.image = image
            pictureLowerRight.image = image;
            //  user.setPicture(picture: imageChosen!.absoluteString)
            
        }

    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToHome") {
            if let destination = segue.destinationController as? HomepageViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
    }

    
}
