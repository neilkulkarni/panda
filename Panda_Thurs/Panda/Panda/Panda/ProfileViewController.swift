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

class ProfileViewController: NSViewController {
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var bioField: NSTextField!
    @IBOutlet weak var pictureField: NSTextField!
    @IBOutlet weak var newBio: NSTextField!
    
    @IBOutlet weak var profilePictureView: NSImageView!
    var user: User = User()
    var id:Int?
    var bio:String?
    var picture:String?
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 255/255.0, green: 220/255.0, blue: 200/255.0, alpha: 0.5)
        
        nameField.stringValue = user.getName()
        emailField.stringValue = user.getEmail()
        newBio.stringValue = user.getBio()
        pictureField.stringValue = user.getPicture()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func editBio(_ sender: Any) {
        bio = newBio.stringValue
        id = user.getID()
        let parameters: Parameters = [
            "id": id!,
            "bio": bio!,
            "picture": ""
        ]
        
        //var isSuccessful = false
        
     /*   Alamofire.request("http://localhost:8081/user", method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
        user.setBio(bio: newBio.stringValue)*/
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
        print(imagePicker.url)
        if(imageChosen != nil ){
            var image = NSImage(contentsOf: imageChosen!)
            profilePictureView.image = image
            
          /*  let parameters: Parameters = [
                "name": name!,
                "bio": bio!,
                "picture": imageChosen!
            ]
            
            var isSuccessful = false
            
            Alamofire.request("http://localhost:8081/user", method: .pull, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if response.result.isSuccess {
                    guard let info = response.result.value else {
                        print("Error")
                        return
                    }
                    
                    let json = JSON(info)*/

            
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
