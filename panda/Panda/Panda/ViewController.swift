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
    
    @IBOutlet weak var emailEntered: NSTextField!
  
    @IBOutlet weak var passwordEntered: NSSecureTextField!

    @IBOutlet weak var emailError: NSTextField!
    //svar user:User?
    var obj = User();
   
   
    
    @IBAction func onClickLogin(_ sender: Any) {
       // var myArray: Array<String> = [];
        //let name = email.stringValue;
        if( errorCheck()) {
            obj.email = emailEntered.stringValue;
            obj.password = passwordEntered.stringValue.md5();
            
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
        if(emailEntered.stringValue == "" || passwordEntered.stringValue == ""){
            emailError.stringValue = "Email or password incorrect";
            return false
        }
        let nameArr = [Character] (emailEntered.stringValue.characters);
        let passArr = [Character] (passwordEntered.stringValue.characters);
        if(nameArr.count >= 100){
             emailError.stringValue = "Invalid Username";
            return false;
        }
        if(passArr.count >= 100) {
            emailError.stringValue = "Invalid Password";
            return false;
        }
        for i  in 0..<nameArr.count {
            if(nameArr[i] == " ") {
                emailError.stringValue = "Invalid Username";
                return false;
            }
        }
        for i in 0..<passArr.count {
            if(passArr[i] == " "){
                emailError.stringValue = "Invalid Password";
                return false;
                
            }
        }
        
        return true
        
    }
    


}

