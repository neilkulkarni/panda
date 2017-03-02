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
       
    }
}

