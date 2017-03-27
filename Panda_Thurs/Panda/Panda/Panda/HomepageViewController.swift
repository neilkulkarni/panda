//
//  HomepageViewController.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/3/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class HomepageViewController: NSViewController {
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 255/255.0, blue: 240/255.0, alpha: 0.5)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func profileButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    @IBAction func planTripButton(_ sender: Any) {
        
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    @IBAction func recordTripButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
}
