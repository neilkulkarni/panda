//
//  TripViewController.swift
//  Panda
//
//  Created by Winnie Lin on 4/5/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class TripViewController: NSViewController {
    var user: User = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
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
  //  @IBOutlet weak var addButtonLowerLeft: NSButton!
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
        if(pictureUpperLeft != nil){
            addButtonUpperLeft.isHidden = true;
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
        if(pictureUpperRight != nil){
           addButtonUpperRight.isHidden = true;
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
        if(pictureLowerLeft != nil){
           addButtonLowerLeft.isHidden = true;
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
        if(pictureLowerRight != nil){
            addButtonLowerRight.isHidden = true;
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
