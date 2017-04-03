//
//  CreateAccountViewController.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/3/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class CreateAccountViewController: NSViewController {

    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var nameErrorLabel: NSTextField!
    
    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var emailErrorLabel: NSTextField!
    
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var passwordErrorLabel1: NSTextField!
    @IBOutlet weak var passwordErrorLabel2: NSTextField!
    @IBOutlet weak var passwordErrorLabel3: NSTextField!
    
    @IBOutlet weak var confirmPasswordField: NSSecureTextField!
    @IBOutlet weak var confirmPasswordErrorLabel: NSTextField!
    
    @IBOutlet weak var termsCheckbox: NSButton!
    @IBOutlet weak var termsErrorLabel: NSTextField!
    
    @IBOutlet weak var profileBioField: NSTextField!
    @IBOutlet weak var profileBioErrorLabel: NSTextField!
    
    @IBOutlet weak var createAccountButton: NSButton!
    @IBOutlet weak var createAccountErrorLabel: NSTextField!
    
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    var user: User = User()
    
    var name:String?
    
    var email:String?
    
    var password:String?
    var confirmPassword:String?
    var bio:String?
    
    var nameErrorFlag:Bool = true;
    var emailErrorFlag:Bool = true;
    var passwordErrorFlag:Bool = true;
    var confirmPasswordErrorFlag:Bool = true;
    var termsErrorFlag:Bool = true;
    var profileBioErrorFlag:Bool = true;
    
    
    @IBAction func exitName(_ sender: Any) {
        name = trim(text: nameField.stringValue)
        
        if (matches (for: "[a-zA-z]+([ '-][a-zA-Z]+)*", in: name!).count == 0) {
            nameErrorLabel.isHidden = false;
            nameErrorFlag = true;
        }
        else {
            nameErrorLabel.isHidden = true;
            nameErrorFlag = false;
            
            enableCreateAccountButton()
        }
    }
    
    @IBAction func exitEmail(_ sender: Any) {
        email = trim(text: emailField.stringValue)
        
        if (matches(for: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$", in: email!).count == 0) {
            emailErrorLabel.isHidden = false;
            emailErrorFlag = true;
        }
        else {
            emailErrorLabel.isHidden = true;
            emailErrorFlag = false;
        }
        
        enableCreateAccountButton()
    }
    
    @IBAction func exitPassword(_ sender: Any) {
        password = trim(text: passwordField.stringValue)
        
        if (matches(for: "^([a-zA-Z0-9]{8,20})$", in: password!).count == 0) {
            passwordErrorLabel1.isHidden = false;
            passwordErrorLabel2.isHidden = false;
            passwordErrorLabel3.isHidden = false;
            passwordErrorFlag = true;
        }
        else {
            passwordErrorLabel1.isHidden = true;
            passwordErrorLabel2.isHidden = true;
            passwordErrorLabel3.isHidden = true;
            passwordErrorFlag = false;
        }
        
        enableCreateAccountButton()
    }
    
    @IBAction func exitConfirmPassword(_ sender: Any) {
        confirmPassword = trim(text: confirmPasswordField.stringValue)
        
        if (password != confirmPassword) {
            confirmPasswordErrorLabel.isHidden = false;
            confirmPasswordErrorFlag = true;
        }
        else {
            confirmPasswordErrorLabel.isHidden = true;
            confirmPasswordErrorFlag = false;
        }
        
        enableCreateAccountButton()
    }
    
    @IBAction func termsSelected(_ sender: Any) {
        if (termsCheckbox.state == NSOffState) {
            termsErrorLabel.isHidden = false;
            termsErrorFlag = true;
        }
        else {
            termsErrorLabel.isHidden = true;
            termsErrorFlag = false;
        }
        
        enableCreateAccountButton()
    }
    
    @IBAction func exitProfileBio(_ sender: Any) {
        
//<<<<<<< Updated upstream
//        bio = ( profileBioField.stringValue);
//=======
        bio = profileBioField.stringValue
//>>>>>>> Stashed changes
        
        if ((self.bio?.characters.count)! > 160) {
            profileBioErrorLabel.isHidden = false
            profileBioErrorFlag = true
        }
        else {
            profileBioErrorLabel.isHidden = true
            profileBioErrorFlag = false
        }
        
        enableCreateAccountButton()
    }
    
    
    func trim(text:String) -> String {
        return text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func enableCreateAccountButton() {
        if (nameErrorFlag || emailErrorFlag || passwordErrorFlag || confirmPasswordErrorFlag || termsErrorFlag || profileBioErrorFlag) {
            createAccountButton.isEnabled = false;
        }
        else {
            createAccountButton.isEnabled = true;
            self.createAccountErrorLabel.isHidden = true;
        }
    }
    
    
    
    @IBAction func createAccount(_ sender: Any) {
        
        bio = profileBioField.stringValue
        let parameters: Parameters = [
            "name": name!,
            "email": email!,
            "password": password!.md5(),
            "bio": bio!,
            "picture": ""
        ]
        
        var isSuccessful = false
        
        Alamofire.request("http://localhost:8081/user", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
                
                print(json)
                print(json["code"])
                
                if (json["code"] == 200) {
                    isSuccessful = true
                }
                else {
                    self.createAccountErrorLabel.isHidden = false
                }
            }
        }
        
        if (isSuccessful) {
            let email = self.email!
            let password = self.password!.md5()
            
            let request = "http://localhost:8081/login?email=" + email + "&password=" + password
            
            Alamofire.request(request).responseJSON { response in
                if response.result.isSuccess {
                    guard let info = response.result.value else {
                        print("Error")
                        return
                    }
                    print(info)
                    
                    let json = JSON(info)
                    
                    
                    
                    self.user.setUser(id: json["user"]["id"].intValue,
                                      name: json["user"]["name"].stringValue,
                                      email: json["user"]["email"].stringValue,
                                      bio: json["user"]["bio"].stringValue,
                                      picture: json["user"]["picture"].stringValue);
                }
            }
        }
        
        createAccountButton.isEnabled = false
    }
    
    
    @IBAction func returnToLoginButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
}
