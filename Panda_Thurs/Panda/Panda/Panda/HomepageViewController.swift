//
//  HomepageViewController.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/3/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class HomepageViewController: NSViewController {
    
    @IBOutlet weak var nameField: NSTextField!
    
    var user: User = User()
    
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 255/255.0, blue: 240/255.0, alpha: 0.5)
        
        nameField.stringValue = user.getName()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func profileButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToProfile", sender: self)
    }
    
    @IBAction func planTripButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToPlan", sender: self)
    }
    
    @IBAction func recordTripButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToRecord", sender: self)
    }
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToProfile") {
            if let destination = segue.destinationController as? ProfileViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        else if (segue.identifier == "idSegueToPlan") {
            if let destination = segue.destinationController as? PlanViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        else if (segue.identifier == "idSegueToRecord") {
            if let destination = segue.destinationController as? RecordViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
    }
}
