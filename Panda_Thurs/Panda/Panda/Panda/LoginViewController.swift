//
//  ViewController.swift
//  Panda
//
//  Created by Winnie Lin on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import CryptoSwift

class LoginViewController: NSViewController {
    @IBOutlet weak var enteredEmail: NSTextField!

    @IBOutlet weak var errortextfield: NSTextField!
    @IBOutlet weak var enteredPassword: NSSecureTextField!
    var obj = User();
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
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
    @IBAction func onClickLogin(_ sender: Any) {
        if( errorCheck()) {
            obj.email = enteredEmail.stringValue;
            obj.password = enteredPassword.stringValue.md5();
            //print( obj.email);
            //print(obj.password);
        }
        
    }
    // check for incorrect input
    func errorCheck() -> Bool {
        if(enteredEmail.stringValue == "" || enteredPassword.stringValue == ""){
            errortextfield.stringValue = "Email or password incorrect";
            return false
        }
        let nameArr = [Character] (enteredEmail.stringValue.characters);
        let passArr = [Character] (enteredPassword.stringValue.characters);
        if(nameArr.count >= 100){
            errortextfield.stringValue = "Invalid Username";
            return false;
        }
        if(passArr.count >= 100) {
            errortextfield.stringValue = "Invalid Password";
            return false;
        }
        for i  in 0..<nameArr.count {
            if(nameArr[i] == " ") {
                errortextfield.stringValue = "Invalid Username";
                return false;
            }
        }
        for i in 0..<passArr.count {
            if(passArr[i] == " "){
                errortextfield.stringValue = "Invalid Password";
                return false;
                
            }
        }
        
        return true
        
    }

    @IBAction func createAnAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    

}

