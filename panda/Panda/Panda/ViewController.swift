//
//  ViewController.swift
//  Panda
//
//  Created by Winnie Lin on 3/1/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import CryptoSwift




class ViewController: NSViewController {
    @IBOutlet weak var email: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!

    @IBOutlet weak var emailError: NSTextField!
   
   
    
    @IBAction func onClickLogin(_ sender: Any) {
        let name = email.stringValue;
        if( errorCheck()) {
        hashing();
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // check for incorrect input
    func errorCheck() -> Bool {
        if(email.stringValue == "" || password.stringValue == ""){
            emailError.stringValue = "Email or password incorrect";
            return false
        }
        return true
        
    }
    // function to hash password
    func hashing(){
        let hash = password.stringValue;
        print( hash.md5());
       
    
    }
    


}

