//
//  ViewController.swift
//  Panda
//
//  Created by Winnie Lin on 2/28/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    @IBOutlet var webview: WebView!
    @IBOutlet weak var email: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!

    @IBOutlet weak var output: NSTextField!
    
    
    var inputName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
   // @IBOutlet weak var createAccount: NSButton!

    @IBAction func onClickLogin(_ sender: NSButton) {
        getName();
                    }
    func getName() {
        //inputName = email.stringValue;
        output.stringValue = email.stringValue;

    }
   
}

