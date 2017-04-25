//
//  FriendProfileViewController.swift
//  Panda
//
//  Created by Aarti Panda on 4/23/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class FriendProfileViewController: NSViewController {
    
    
    @IBOutlet weak var profilePictureView: NSImageView!
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var bioField: NSTextField!
    
    @IBOutlet weak var tripTitleField: NSTextField!
    
    
    
    
    var user: User = User()
    var friend: User = User()
    var id:Int?
    var bio:String?
    var picture:String?
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 255/255.0, green: 220/255.0, blue: 200/255.0, alpha: 0.5)
        
        nameField.stringValue = friend.getName()
        bioField.stringValue = friend.getBio()
        
        if(friend.getPicture() != "") {
            var urlStr = URL(string: friend.getPicture())
            profilePictureView.image = NSImage(contentsOf: urlStr!)
        }
        else {
            print("picture!!!")
            profilePictureView.image = #imageLiteral(resourceName: "pandaicon2.png")
        }
        
    }
    
    @IBAction func viewTripButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToTrip", sender: self)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //TODO: get profile pic
    }
    
    
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToHome") {
            if let destination = segue.destinationController as? HomepageViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        else if (segue.identifier == "idSegueToFriendTrip") {
            if let destination = segue.destinationController as? FriendTripViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
                destination.friend.setUser(id: friend.getID(), name: friend.getName(), email: friend.getEmail(), bio: friend.getBio(), picture: friend.getPicture())
            }
        }
    }
    
    
}
