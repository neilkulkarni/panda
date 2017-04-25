//
//  RecordViewController.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/3/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import MapKit
import WebKit
import Foundation
import SwiftyJSON
import Alamofire

class RecordViewController: NSViewController {
    
    var user: User = User()
    var tripID: TripID = TripID()

    @IBOutlet weak var resultsTableView: NSTableView!
    
    //@IBOutlet weak var webPageView: WebView!
    
    @IBOutlet weak var mapWebView: WebView!
    var imageString: String = ""

    func generateMap() {
        //selected list
        //https://maps.googleapis.com/maps/api/staticmap?size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318 &markers=color:red%7Clabel:C%7C40.718217,-73.998284 &key=AIzaSyCqXFkHzOLwEw00zOTq_1kzGwkgNjAKHTE
        imageString = "https://maps.googleapis.com/maps/api/staticmap?size=600x300&maptype=roadmap"
        
        if (selectedList.count == 0) {
            return
        }
        
        for i in 0...(selectedList.count-1){
            var temp:String = ""
            if(i == 0){ temp = "A" }
            else if (i == 1){ temp = "B" }
            else if (i == 2){ temp = "C" }
            else if (i == 3){ temp = "D" }
            else if (i == 4){ temp = "E" }
            else if (i == 5){ temp = "F" }
            else if (i == 6){ temp = "G" }
            else if (i == 7){ temp = "H" }
            else if (i == 8){ temp = "I" }
            else if (i == 9){ temp = "J" }
            
            let initString = selectedList[i].address
            let addressString = initString?.replacingOccurrences(of: " ", with: "+")

            imageString += "&markers=size:mid%7Ccolor:red%7Clabel:" + temp + "%7C"
            imageString += addressString!
        }
        
        imageString += "&key=AIzaSyCqXFkHzOLwEw00zOTq_1kzGwkgNjAKHTE"
        print(imageString)
        

        let requesturl = URL(string: imageString)
        print(requesturl)
        let request = URLRequest(url: requesturl!)
        print(request)
        mapWebView.mainFrame.load(request)
        
//        let requesturl = NSURL(string: imageString)
//        let request = NSURLRequest(url: requesturl!)
//        mapWebView.mainFrame.load(request)
//        
       //mapWebView.loadRequest(NSURLRequest(URL: NSURL(imageString)!))
        
        
        //mapWebView.isHidden = false
    }
    
    @IBOutlet weak var startingAddress: NSTextField!

    @IBOutlet weak var imageThing: NSImageView!
    
    var businessList: [Business] = []
    var selectedList: [Business] = []
    var orderedList: [Business] = []
    
    @IBOutlet weak var selection1: NSTextField!

    @IBOutlet weak var selection2: NSTextField!
    
    @IBOutlet weak var selection3: NSTextField!
    @IBOutlet weak var selection4: NSTextField!
    @IBOutlet weak var selection5: NSTextField!
    @IBOutlet weak var selection6: NSTextField!
    @IBOutlet weak var selection7: NSTextField!
    @IBOutlet weak var selection8: NSTextField!
    @IBOutlet weak var selection9: NSTextField!
    @IBOutlet weak var selection10: NSTextField!
    
    @IBOutlet weak var removeButton1: NSButton!
    @IBOutlet weak var removeButton2: NSButton!
    @IBOutlet weak var removeButton3: NSButton!
    @IBOutlet weak var removeButton4: NSButton!
    @IBOutlet weak var removeButton5: NSButton!
    @IBOutlet weak var removeButton6: NSButton!
    @IBOutlet weak var removeButton7: NSButton!
    @IBOutlet weak var removeButton8: NSButton!
    @IBOutlet weak var removeButton9: NSButton!
    @IBOutlet weak var removeButton10: NSButton!
    
    
    @IBOutlet weak var tripTitle: NSTextField!
    @IBOutlet weak var tripDescription: NSTextField!
    @IBOutlet weak var finalizeTripButton: NSButton!
    
    @IBOutlet weak var generateMapButton: NSButton!
    
    @IBAction func selectLocationButton(_ sender: Any) {
        let row = resultsTableView.selectedRow
        if (row >= 0 && selectedList.count < 10) {
            selectedList.append(businessList[row])
            
            var locationSearchQuery: String = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + selectedList[selectedList.count-1].latitude! + "," + selectedList[selectedList.count-1].longitude!
            locationSearchQuery += "&key=AIzaSyAgh9MvQLlmI8wgO4UDGrGzqKFTdNM-iNA" //adds my api key
            Alamofire.request(locationSearchQuery, method: .post, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                
                if response.result.isSuccess {
                    guard let info = response.result.value else {
                        print("Error")
                        return
                    }
                    //print(info)
                    let json = JSON(info)
                    //print(json)
                    print(json["results"][0]["address_components"][2]["types"][0].stringValue)
                    for i in 0...(json["results"][0]["address_components"].count-1) {
                        for j in 0...(json["results"][0]["address_components"][i]["types"].count-1) {
                            if (json["results"][0]["address_components"][i]["types"][j].stringValue == "locality") {
                                self.selectedList[self.selectedList.count-1].location = json["results"][0]["address_components"][i]["short_name"].stringValue
                            }
                        }
                    }
                    
                    //self.storeResults()
                    //self.token = json["access_token"].stringValue
                    
                }
                //print(self.selectedList[self.selectedList.count-1].location)
            }

            
            popUpButton1.addItem(withTitle: "\(selectedList.count)")
            popUpButton2.addItem(withTitle: "\(selectedList.count)")
            popUpButton3.addItem(withTitle: "\(selectedList.count)")
            popUpButton4.addItem(withTitle: "\(selectedList.count)")
            popUpButton5.addItem(withTitle: "\(selectedList.count)")
            popUpButton6.addItem(withTitle: "\(selectedList.count)")
            popUpButton7.addItem(withTitle: "\(selectedList.count)")
            popUpButton8.addItem(withTitle: "\(selectedList.count)")
            popUpButton9.addItem(withTitle: "\(selectedList.count)")
            popUpButton10.addItem(withTitle: "\(selectedList.count)")
            
            for i in 0...(selectedList.count - 1) {
                if (i == 0) {
                    selection1.isHidden = false
                    selection1.stringValue = selectedList[i].name!
                    popUpButton1.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton1.selectItem(at: i)
                    }
                    removeButton1.isHidden = false
                }
                else if (i == 1) {
                    selection2.isHidden = false
                    selection2.stringValue = selectedList[i].name!
                    popUpButton2.isHidden = false
                    reorderButton.isHidden = false
                    
                    if (i == selectedList.count - 1) {
                        popUpButton2.selectItem(at: i)
                    }
                    removeButton2.isHidden = false
                }
                else if (i == 2) {
                    selection3.isHidden = false
                    selection3.stringValue = selectedList[i].name!
                    popUpButton3.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton3.selectItem(at: i)
                    }
                    removeButton3.isHidden = false
                }
                else if (i == 3) {
                    selection4.isHidden = false
                    selection4.stringValue = selectedList[i].name!
                    popUpButton4.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton4.selectItem(at: i)
                    }
                    removeButton4.isHidden = false
                }
                else if (i == 4) {
                    selection5.isHidden = false
                    selection5.stringValue = selectedList[i].name!
                    popUpButton5.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton5.selectItem(at: i)
                    }
                    removeButton5.isHidden = false
                }
                else if (i == 5) {
                    selection6.isHidden = false
                    selection6.stringValue = selectedList[i].name!
                    popUpButton6.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton6.selectItem(at: i)
                    }
                    removeButton6.isHidden = false
                }
                else if (i == 6) {
                    selection7.isHidden = false
                    selection7.stringValue = selectedList[i].name!
                    popUpButton7.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton7.selectItem(at: i)
                    }
                    removeButton7.isHidden = false
                }
                else if (i == 7) {
                    selection8.isHidden = false
                    selection8.stringValue = selectedList[i].name!
                    popUpButton8.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton8.selectItem(at: i)
                    }
                    removeButton8.isHidden = false
                }
                else if (i == 8) {
                    selection9.isHidden = false
                    selection9.stringValue = selectedList[i].name!
                    popUpButton9.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton9.selectItem(at: i)
                    }
                    removeButton9.isHidden = false
                }
                else if (i == 9) {
                    selection10.isHidden = false
                    selection10.stringValue = selectedList[i].name!
                    popUpButton10.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton10.selectItem(at: i)
                    }
                    removeButton10.isHidden = false
                }
            }
        }
        
        /*if (selectedList.count > 0) {
            generateMapButton.isHidden = false
        }*/
    }

    @IBAction func removeLocationButton1(_ sender: Any) {
        if (selectedList.count > 0) {
            for i in 0 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 0) {
                        selection1.isHidden = true
                        selection1.stringValue = ""
                        popUpButton1.isHidden = true
                        removeButton1.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 1) {
                        selection2.isHidden = true
                        selection2.stringValue = ""
                        popUpButton2.isHidden = true
                        removeButton2.isHidden = true
                        reorderButton.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 2) {
                        selection3.isHidden = true
                        selection3.stringValue = ""
                        popUpButton3.isHidden = true
                        removeButton3.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 3) {
                        selection4.isHidden = true
                        selection4.stringValue = ""
                        popUpButton4.isHidden = true
                        removeButton4.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 4) {
                        selection5.isHidden = true
                        selection5.stringValue = ""
                        popUpButton5.isHidden = true
                        removeButton5.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 5) {
                        selection6.isHidden = true
                        selection6.stringValue = ""
                        popUpButton6.isHidden = true
                        removeButton6.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 6) {
                        selection7.isHidden = true
                        selection7.stringValue = ""
                        popUpButton7.isHidden = true
                        removeButton7.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton9.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 0) {
                    selection1.stringValue = selectedList[i].name!
                }
                if (i == 1) {
                    selection2.stringValue = selectedList[i].name!
                }
                if (i == 2) {
                    selection3.stringValue = selectedList[i].name!
                }
                if (i == 3) {
                    selection4.stringValue = selectedList[i].name!
                }
                if (i == 4) {
                    selection5.stringValue = selectedList[i].name!
                }
                if (i == 5) {
                    selection6.stringValue = selectedList[i].name!
                }
                if (i == 6) {
                    selection7.stringValue = selectedList[i].name!
                }
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton2(_ sender: Any) {
        if (selectedList.count > 1) {
            for i in 1 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 1) {
                        selection2.isHidden = true
                        selection2.stringValue = ""
                        popUpButton2.isHidden = true
                        removeButton2.isHidden = true
                        
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 2) {
                        selection3.isHidden = true
                        selection3.stringValue = ""
                        popUpButton3.isHidden = true
                        removeButton3.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 3) {
                        selection4.isHidden = true
                        selection4.stringValue = ""
                        popUpButton4.isHidden = true
                        removeButton4.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 4) {
                        selection5.isHidden = true
                        selection5.stringValue = ""
                        popUpButton5.isHidden = true
                        removeButton5.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 5) {
                        selection6.isHidden = true
                        selection6.stringValue = ""
                        popUpButton6.isHidden = true
                        removeButton6.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 6) {
                        selection7.isHidden = true
                        selection7.stringValue = ""
                        popUpButton7.isHidden = true
                        removeButton7.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        popUpButton9.isHidden = true
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 1) {
                    selection2.stringValue = selectedList[i].name!
                }
                if (i == 2) {
                    selection3.stringValue = selectedList[i].name!
                }
                if (i == 3) {
                    selection4.stringValue = selectedList[i].name!
                }
                if (i == 4) {
                    selection5.stringValue = selectedList[i].name!
                }
                if (i == 5) {
                    selection6.stringValue = selectedList[i].name!
                }
                if (i == 6) {
                    selection7.stringValue = selectedList[i].name!
                }
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton3(_ sender: Any) {
        if (selectedList.count > 2) {
            for i in 2 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 2) {
                        selection3.isHidden = true
                        selection3.stringValue = ""
                        popUpButton3.isHidden = true
                        removeButton3.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 3) {
                        selection4.isHidden = true
                        selection4.stringValue = ""
                        popUpButton4.isHidden = true
                        removeButton4.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 4) {
                        selection5.isHidden = true
                        selection5.stringValue = ""
                        popUpButton5.isHidden = true
                        removeButton5.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 5) {
                        selection6.isHidden = true
                        selection6.stringValue = ""
                        popUpButton6.isHidden = true
                        removeButton6.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 6) {
                        selection7.isHidden = true
                        selection7.stringValue = ""
                        popUpButton7.isHidden = true
                        removeButton7.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton9.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 2) {
                    selection3.stringValue = selectedList[i].name!
                }
                if (i == 3) {
                    selection4.stringValue = selectedList[i].name!
                }
                if (i == 4) {
                    selection5.stringValue = selectedList[i].name!
                }
                if (i == 5) {
                    selection6.stringValue = selectedList[i].name!
                }
                if (i == 6) {
                    selection7.stringValue = selectedList[i].name!
                }
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton4(_ sender: Any) {
        if (selectedList.count > 3) {
            for i in 3 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 3) {
                        selection4.isHidden = true
                        selection4.stringValue = ""
                        popUpButton4.isHidden = true
                        removeButton4.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        break
                    }
                    if (i == 4) {
                        selection5.isHidden = true
                        selection5.stringValue = ""
                        popUpButton5.isHidden = true
                        removeButton5.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 5) {
                        selection6.isHidden = true
                        selection6.stringValue = ""
                        popUpButton6.isHidden = true
                        removeButton6.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 6) {
                        selection7.isHidden = true
                        selection7.stringValue = ""
                        popUpButton7.isHidden = true
                        removeButton7.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton9.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 3) {
                    selection4.stringValue = selectedList[i].name!
                }
                if (i == 4) {
                    selection5.stringValue = selectedList[i].name!
                }
                if (i == 5) {
                    selection6.stringValue = selectedList[i].name!
                }
                if (i == 6) {
                    selection7.stringValue = selectedList[i].name!
                }
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton5(_ sender: Any) {
        if (selectedList.count > 4) {
            for i in 4 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 4) {
                        selection5.isHidden = true
                        selection5.stringValue = ""
                        popUpButton5.isHidden = true
                        removeButton5.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 5) {
                        selection6.isHidden = true
                        selection6.stringValue = ""
                        popUpButton6.isHidden = true
                        removeButton6.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 6) {
                        selection7.isHidden = true
                        selection7.stringValue = ""
                        popUpButton7.isHidden = true
                        removeButton7.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton9.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 4) {
                    selection5.stringValue = selectedList[i].name!
                }
                if (i == 5) {
                    selection6.stringValue = selectedList[i].name!
                }
                if (i == 6) {
                    selection7.stringValue = selectedList[i].name!
                }
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton6(_ sender: Any) {
        if (selectedList.count > 5) {
            for i in 5 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 5) {
                        selection6.isHidden = true
                        selection6.stringValue = ""
                        popUpButton6.isHidden = true
                        removeButton6.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 6) {
                        selection7.isHidden = true
                        selection7.stringValue = ""
                        popUpButton7.isHidden = true
                        removeButton7.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton9.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 5) {
                    selection6.stringValue = selectedList[i].name!
                }
                if (i == 6) {
                    selection7.stringValue = selectedList[i].name!
                }
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton7(_ sender: Any) {
        if (selectedList.count > 6) {
            for i in 6 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 6) {
                        selection7.isHidden = true
                        selection7.stringValue = ""
                        popUpButton7.isHidden = true
                        removeButton7.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton9.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 6) {
                    selection7.stringValue = selectedList[i].name!
                }
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton8(_ sender: Any) {
        if (selectedList.count > 7) {
            for i in 7 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 7) {
                        selection8.isHidden = true
                        selection8.stringValue = ""
                        popUpButton8.isHidden = true
                        removeButton8.isHidden = true
                        
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton8.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 7) {
                    selection8.stringValue = selectedList[i].name!
                }
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton9(_ sender: Any) {
        if (selectedList.count > 8) {
            for i in 8 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 8) {
                        selection9.isHidden = true
                        selection9.stringValue = ""
                        popUpButton9.isHidden = true
                        removeButton9.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 8) {
                    selection9.stringValue = selectedList[i].name!
                }
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBAction func removeLocationButton10(_ sender: Any) {
        if (selectedList.count > 9) {
            for i in 9 ... selectedList.count - 1 {
                if (i == selectedList.count - 1) {
                    if (i == 9) {
                        selection10.isHidden = true
                        selection10.stringValue = ""
                        popUpButton10.isHidden = true
                        removeButton10.isHidden = true
                        
                        popUpButton1.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton2.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton3.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton4.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton5.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton6.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton7.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton8.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton9.removeItem(withTitle: "\(selectedList.count)")
                        popUpButton10.removeItem(withTitle: "\(selectedList.count)")
                        selectedList.remove(at: selectedList.count-1)
                        
                        break
                    }
                }
                selectedList[i] = selectedList[i+1]
                if (i == 9) {
                    selection10.stringValue = selectedList[i].name!
                }
            }
        }
    }
    
    @IBOutlet weak var popUpButton1: NSPopUpButton!
    @IBOutlet weak var popUpButton2: NSPopUpButton!
    @IBOutlet weak var popUpButton3: NSPopUpButton!
    @IBOutlet weak var popUpButton4: NSPopUpButton!
    @IBOutlet weak var popUpButton5: NSPopUpButton!
    @IBOutlet weak var popUpButton6: NSPopUpButton!
    @IBOutlet weak var popUpButton7: NSPopUpButton!
    @IBOutlet weak var popUpButton8: NSPopUpButton!
    @IBOutlet weak var popUpButton9: NSPopUpButton!
    @IBOutlet weak var popUpButton10: NSPopUpButton!

    @IBOutlet weak var reorderButton: NSButton!

    
    @IBAction func reorderButton(_ sender: Any) {
        orderedList.removeAll()
        
        for i in 0..<selectedList.count {
            if(0 < selectedList.count && popUpButton1.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[0])
            }
            if (1 < selectedList.count && popUpButton2.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[1])
            }
            if (2 < selectedList.count && popUpButton3.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[2])
            }
            if (3 < selectedList.count && popUpButton4.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[3])
            }
            if (4 < selectedList.count && popUpButton5.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[4])
            }
            if (5 < selectedList.count && popUpButton6.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[5])
            }
            if (6 < selectedList.count && popUpButton7.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[6])
            }
            if (7 < selectedList.count && popUpButton8.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[7])
            }
            if (8 < selectedList.count && popUpButton9.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[8])
            }
            if (9 < selectedList.count && popUpButton10.selectedItem?.title == "\(i+1)") {
                orderedList.append(selectedList[9])
            }
        }
        
        if (0 < orderedList.count) {
            selection1.stringValue = orderedList[0].name!
            popUpButton1.selectItem(at: 0)
        }
        if (1 < orderedList.count) {
            selection2.stringValue = orderedList[1].name!
            popUpButton2.selectItem(at: 1)
        }
        if (2 < orderedList.count) {
            selection3.stringValue = orderedList[2].name!
            popUpButton3.selectItem(at: 2)
        }
        if (3 < orderedList.count) {
            selection4.stringValue = orderedList[3].name!
            popUpButton4.selectItem(at: 3)
        }
        if (4 < orderedList.count) {
            selection5.stringValue = orderedList[4].name!
            popUpButton5.selectItem(at: 4)
        }
        if (5 < orderedList.count) {
            selection6.stringValue = orderedList[5].name!
            popUpButton6.selectItem(at: 5)
        }
        if (6 < orderedList.count) {
            selection7.stringValue = orderedList[6].name!
            popUpButton7.selectItem(at: 6)
        }
        if (7 < orderedList.count) {
            selection8.stringValue = orderedList[7].name!
            popUpButton8.selectItem(at: 7)
        }
        if (8 < orderedList.count) {
            selection9.stringValue = orderedList[8].name!
            popUpButton9.selectItem(at: 8)
        }
        if (9 < orderedList.count) {
            selection10.stringValue = orderedList[9].name!
            popUpButton10.selectItem(at: 9)
        }
        
        selectedList.removeAll()
        for j in 0..<orderedList.count {
            selectedList.append(orderedList[j])
        }
    }
    
    
    
    
    
    
    func loadBusinessResults() {
        let numRows = resultsTableView.numberOfRows
        var rangeToRemove: IndexSet = []
        rangeToRemove.insert(integersIn: 0..<numRows)
        resultsTableView.removeRows(at: rangeToRemove, withAnimation: NSTableViewAnimationOptions.effectFade)
        
        var rangeToAdd: IndexSet = []
        rangeToAdd.insert(integersIn: 0..<businessList.count)
        resultsTableView.insertRows(at: rangeToAdd, withAnimation: NSTableViewAnimationOptions.slideUp)
    }
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 220/255.0, blue: 255/255.0, alpha: 0.5)
    }

    
    @IBAction func searchButton(_ sender: Any) {
        if (startingAddress.stringValue.characters.count == 0) {
            startingAddress.stringValue = "Purdue University"
        }
        
        let tempArr = startingAddress.stringValue
        var myStringArr = tempArr.components(separatedBy: " ")
        print(myStringArr)
        var locationSearchQuery: String = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="
        for i in 0...myStringArr.count-1 {
            if(i == myStringArr.count - 1){
                locationSearchQuery += myStringArr[i]
            }
            else{
                locationSearchQuery += myStringArr[i] + "+"
            }
        }
        locationSearchQuery += "&key=AIzaSyBWfX3R3fATFRM8UXGrHYIKARQ3Vu33KDc" //adds my api key
        //should have the address in the processed format
        print(locationSearchQuery)
        
        
        Alamofire.request(locationSearchQuery, method: .post, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isSuccess {
                guard let info = response.result.value else {
                    print("Error")
                    return
                }
                //print(info)
                let json = JSON(info)
                //print(json)
                
                let businesses = json["results"].arrayValue
                
                self.businessList.removeAll()
                
                for i in 0...(businesses.count - 1) {
                    self.businessList.append(self.convertToBusiness(businessObject: businesses[i]))
                    
                }
                
                //fields i'm using are name, address, first type
                
                
                print(self.businessList[0].name)
                print(self.businessList[0].address)
                
                self.loadBusinessResults()
                
                //self.storeResults()
                //self.token = json["access_token"].stringValue
                
            }
        }
    }
    
    
    func convertToBusiness(businessObject: JSON) -> Business{
        let tempBusiness:Business = Business()
        tempBusiness.image = NSImage(byReferencingFile: businessObject["icon"].stringValue)                 ///needs to be changed if we want the actual picture
        tempBusiness.name = businessObject["name"].stringValue
        tempBusiness.rating = businessObject["rating"].double
        tempBusiness.category = businessObject["types"][0].stringValue
        tempBusiness.price = businessObject["price_level"].stringValue
        tempBusiness.url = businessObject["id"].stringValue             //set to be the id for now
        tempBusiness.latitude = businessObject["geometry"]["location"]["lat"].stringValue
        tempBusiness.longitude = businessObject["geometry"]["location"]["lng"].stringValue
        tempBusiness.address = businessObject["formatted_address"].stringValue
        return tempBusiness
        
    }
    
//    func storeResults(){
//
//    }
    
    @IBOutlet weak var mapView: MKMapView!
//    override func viewWillAppear() {
//        self.view.wantsLayer = true;
//        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 220/255.0, blue: 255/255.0, alpha: 0.5)
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//        NSRect frame=[NSScreen mainScreen].frame ;
//        [self.window setFrame:frame display:YES animate:YES]
//        
//        var mainScreen: NSScreen
//        var frame: NSRect = mainScreen.frame
        
//        webPageView2.mainFrameURL = "https://www.google.com/maps/dir//Amazon+Purdue+-+PMU,+Purdue+Memorial+Union,+101+N+Grant+St,+West+Lafayette,+IN+47906/@40.4247509,-86.9134973,17z/data=!4m15!1m6!3m5!1s0x8812e2ae143f97df:0x20aa3a995b5da242!2sAmazon+Purdue+-+PMU!8m2!3d40.4247468!4d-86.9113086!4m7!1m0!1m5!1m1!1s0x8812e2ae143f97df:0x20aa3a995b5da242!2m2!1d-86.9113086!2d40.4247468"
//        webPageView2.reload(self)
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        popUpButton1.removeAllItems()
        popUpButton2.removeAllItems()
        popUpButton3.removeAllItems()
        popUpButton4.removeAllItems()
        popUpButton5.removeAllItems()
        popUpButton6.removeAllItems()
        popUpButton7.removeAllItems()
        popUpButton8.removeAllItems()
        popUpButton9.removeAllItems()
        popUpButton10.removeAllItems()
        finalizeTripButton.isEnabled = false
        
    }
    @IBOutlet weak var tripSavedLabel: NSTextField!
    @IBAction func saveTripButtonClick(_ sender: Any) {
        if (selectedList.count == 0) {
            return
        }
        generateMap()
        uploadTrip()
        finalizeTripButton.isEnabled = true
        tripSavedLabel.isHidden = false
    }
    
    @IBAction func homeButtone(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    @IBAction func goToMyTripButton(_ sender: Any) {
        //uploadTrip()
        performSegue(withIdentifier: "idSegueToMyTrip", sender: self)
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToHome") {
            if let destination = segue.destinationController as? HomepageViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        if (segue.identifier == "idSegueToMyTrip") {
            if let destination = segue.destinationController as? TripViewController {
                //uploadTrip()
                destination.trip_id.setID(id: tripID.getID())
                print(destination.trip_id)
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
    }
    
    var tripLocationName = ""
    
    //TODO: complete this method
    func determineLocationName() {
        //var cityList = [String]()
        var max = 0
        var maxLocation = -1;
        for i in 0...selectedList.count - 1{
            //cityList[i] = selectedList[i].location!
            //should have the address in the processed format
            var count = 0
            for j in 0...selectedList.count - 1{
                if(selectedList[i].location! == selectedList[j].location){
                    count += 1
                }
            }
            if(count > max){
                max = count
                maxLocation = i
            }
        }
        tripLocationName = selectedList[maxLocation].location!
        
    }
    
    func uploadTrip() {
        determineLocationName()
        
        let tripParams: Parameters = [
            "name": tripTitle.stringValue,
            "description": tripDescription.stringValue,
            "location": tripLocationName,
            "private": 0,
            "api": imageString,
            "user_id": user.id
        ]
        
        //print(tripParams)
        
        
        Alamofire.request("http://localhost:8081/trip", method: .post, parameters: tripParams, encoding: JSONEncoding.default).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            guard let info = response.result.value else {
                print("Error")
                return
            }
            
            let json = JSON(info)
            print(json)
            self.tripID.setID(id: json["trip_id"].int!)
            self.uploadEvents(id: self.tripID.getID())
        }
        //print(id)
        //uploadEvents(id: id)
        //return id
    }
    
    func uploadEvents(id: Int) {
        //print(id)
        for i in 0...(selectedList.count - 1) {
            var eventName = selectedList[i].name
            var eventLat = selectedList[i].latitude
            var eventLong = selectedList[i].longitude
            
            let eventParams: Parameters = [
                "name": eventName!,
                "order": i + 1,
                "description": "",
                "latitude": selectedList[i].latitude,
                "longitude": selectedList[i].longitude,
                "picture1": "",
                "picture2": "",
                "picture3": "",
                "picture4": "",
                "date": "",
                "api": "",
                "trip_id": id
            ]
            
            Alamofire.request("http://localhost:8081/event", method: .post, parameters: eventParams, encoding: JSONEncoding.default).responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                guard let info = response.result.value else {
                    print("Error")
                    return
                }
                
                let json = JSON(info)
                print(json)
            }
        }
    }
}

extension RecordViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return businessList.count ?? 0
    }
    
}

extension RecordViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "NameCellID"
        static let CategoryCell = "CategoryCellID"
        static let AddressCell = "AddressCellID"
        //static let RatingCell = "RatingCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        
        // 1
        var item: Business = Business()
        if (self.businessList[row] != nil) {
            item = self.businessList[row]
        }
        else {
            return nil
        }
        
        print("business:")
        //print(self.toString(item: item))
        //FIND PRINT METHOD HERE
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = item.name!
            cellIdentifier = CellIdentifiers.NameCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.category!
//            if (text.characters.count == 0) {
//                text = text.capitalized
//            }
            cellIdentifier = CellIdentifiers.CategoryCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = item.address!
            cellIdentifier = CellIdentifiers.AddressCell
        }
        
        // 3
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        
        return nil
    }
    
}


