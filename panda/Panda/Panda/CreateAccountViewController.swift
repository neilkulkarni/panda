//
//  CreateAccountViewController.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class CreateAccountViewController: NSViewController {

    @IBOutlet weak var firstNameField: NSTextField!
    @IBOutlet weak var lastNameField: NSTextField!
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
    
    @IBOutlet weak var createAccountErrorLabel: NSTextField!
    
    var firstName:String?
    var lastName:String?
    
    var email:String?
    
    var password:String?
    var confirmPassword:String?
    
    
    @IBAction func createAccountButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func exitFirstNameField(_ sender: Any) {
    }
    
    @IBAction func exitEmailField(_ sender: Any) {
        print("I exited email field!")
    }
}
