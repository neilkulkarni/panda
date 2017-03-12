//
//  CustomSegue.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/3/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa

class CustomSegue: NSStoryboardSegue {
    
    override func perform() {
        let source = sourceController as! NSViewController
        let destination = destinationController as! NSViewController
        
        source.view.window?.contentViewController = destination
        source.removeFromParentViewController()
    }

    
}
