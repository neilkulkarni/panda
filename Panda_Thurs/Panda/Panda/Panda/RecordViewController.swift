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

    @IBOutlet weak var resultsTableView: NSTableView!
    
    //@IBOutlet weak var webPageView: WebView!
    

    
    @IBOutlet weak var startingAddress: NSTextField!

    
    var businessList: [Business] = []
    var selectedList: [Business] = []
    
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
    
    @IBOutlet weak var tripTitle: NSTextField!
    @IBOutlet weak var tripDescription: NSTextField!
    
    
    @IBAction func selectLocationButton(_ sender: Any) {
        let row = resultsTableView.selectedRow
        if (row >= 0 && selectedList.count < 10) {
            selectedList.append(businessList[row])
            
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
                }
                else if (i == 1) {
                    selection2.isHidden = false
                    selection2.stringValue = selectedList[i].name!
                    popUpButton2.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton2.selectItem(at: i)
                    }
                }
                else if (i == 2) {
                    selection3.isHidden = false
                    selection3.stringValue = selectedList[i].name!
                    popUpButton3.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton3.selectItem(at: i)
                    }
                }
                else if (i == 3) {
                    selection4.isHidden = false
                    selection4.stringValue = selectedList[i].name!
                    popUpButton4.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton4.selectItem(at: i)
                    }
                }
                else if (i == 4) {
                    selection5.isHidden = false
                    selection5.stringValue = selectedList[i].name!
                    popUpButton5.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton5.selectItem(at: i)
                    }
                }
                else if (i == 5) {
                    selection6.isHidden = false
                    selection6.stringValue = selectedList[i].name!
                    popUpButton6.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton6.selectItem(at: i)
                    }
                }
                else if (i == 6) {
                    selection7.isHidden = false
                    selection7.stringValue = selectedList[i].name!
                    popUpButton7.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton7.selectItem(at: i)
                    }
                }
                else if (i == 7) {
                    selection8.isHidden = false
                    selection8.stringValue = selectedList[i].name!
                    popUpButton8.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton8.selectItem(at: i)
                    }
                }
                else if (i == 8) {
                    selection9.isHidden = false
                    selection9.stringValue = selectedList[i].name!
                    popUpButton9.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton9.selectItem(at: i)
                    }
                }
                else if (i == 9) {
                    selection10.isHidden = false
                    selection10.stringValue = selectedList[i].name!
                    popUpButton10.isHidden = false
                    if (i == selectedList.count - 1) {
                        popUpButton10.selectItem(at: i)
                    }
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
        let tempArr = startingAddress.stringValue
        var myStringArr = tempArr.components(separatedBy: " ")
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
        tempBusiness.latitude = businessObject["geometry.location.lat"].double
        tempBusiness.longitude = businessObject["geometry.location.lng"].double
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
        
    }
    
    @IBAction func homeButtone(_ sender: Any) {
         performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
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


