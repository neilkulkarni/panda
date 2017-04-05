//
//  ViewController.swift
//  Panda
//
//  Created by Winnie Lin on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import CryptoSwift
import Alamofire
import SwiftyJSON

class LoginViewController: NSViewController {
    @IBOutlet weak var enteredEmail: NSTextField!

    @IBOutlet weak var errortextfield: NSTextField!
    @IBOutlet weak var enteredPassword: NSSecureTextField!
    
    @IBOutlet weak var verifyCheckbox: NSButton!
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var loginErrorLabel: NSTextField!
    
    
    var user: User = User()
    
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

    
    @IBAction func verifyCheckboxSelected(_ sender: Any) {
        
        let email = enteredEmail.stringValue
        let password = enteredPassword.stringValue.md5()
        
        //var emailMatches:Bool = false
        var passwordMatches:Bool = false
        var request = "http://localhost:8081/login?email=" + email + "&password=" + password
        
        Alamofire.request(request).responseJSON { response in
            if response.result.isSuccess {
                guard let info = response.result.value else {
                    print("Error")
                    return
                }
                print(info)
                
                let json = JSON(info)
                if (json["user"]["email"].string != email || json["user"]["password"].string != password) {
                    print("not verified")
                    self.verifyCheckbox.state = NSOffState;
                    self.loginErrorLabel.isHidden = false;
                }
                else {
                    print("verified")
                    self.loginButton.isEnabled = true;
                    self.loginErrorLabel.isHidden = true;
                    
                    self.user.setUser(id: json["user"]["id"].intValue,
                                name: json["user"]["name"].stringValue,
                                email: json["user"]["email"].stringValue,
                                bio: json["user"]["bio"].stringValue,
                                picture: json["user"]["picture"].stringValue);
                }
                
                //-----------Old Code: In case s**t hits the fan
                /*print(json["userList"])
                print(json["userList"][0])
                print(json["userList"][0]["email"])
                print(json["userList"].count)
                
                for i in 0..<json["userList"].count {
                    if (email == json["userList"][i]["email"].string) {
                        id = i
                        emailMatches = true
                        break
                    }
                }
                
                if (emailMatches) {
                    if (password == json["userList"][id]["password"].string) {
                        passwordMatches = true;
                    }
                }
                
                print(password)
                print(passwordMatches)
            
                if (passwordMatches) {
                    print("verified")
                    self.loginButton.isEnabled = true;
                    self.loginErrorLabel.isHidden = true;
                }
                else {
                    print("not verified")
                    self.verifyCheckbox.state = NSOffState;
                    self.loginErrorLabel.isHidden = false;
                }*/
            }
            
            
        }
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToHome", sender: self)
    }

    @IBAction func createAnAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToHome") {
            if let destination = segue.destinationController as? HomepageViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
    }
}

