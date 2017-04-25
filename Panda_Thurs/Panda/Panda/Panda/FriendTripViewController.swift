//
//  FriendTripViewController.swift
//  Panda
//
//  Created by Aarti Panda on 4/23/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import MapKit
import WebKit

class FriendTripViewController: NSViewController {
    
    var user: User = User()
    var friend: User = User()
    var trip_id: TripID = TripID()
    var eventList: [Event] = []
    var selectedEvent: Event = Event()
    
    


    @IBOutlet weak var tripNameField: NSTextField!
    @IBOutlet weak var tripDescriptionField: NSTextField!
    @IBOutlet weak var mapWebView2: WebView!
    @IBOutlet weak var resultsTableView: NSTableView!
    
    @IBOutlet weak var pictureUpperLeft: NSImageView!
    @IBOutlet weak var pictureUpperRight: NSImageView!
    @IBOutlet weak var pictureLowerLeft: NSImageView!
    @IBOutlet weak var pictureLowerRight: NSImageView!
    @IBOutlet weak var eventDescription: NSTextField!
    
    
    var picture1URL = ""
    var picture2URL = ""
    var picture3URL = ""
    var picture4URL = ""
    var eventID: Int = -1
    
//    @IBAction func resultsTableViewClick(_ sender: Any) {
//
//    }
    @IBAction func resultsTableViewClick(_ sender: Any) {
        if (resultsTableView.clickedRow == -1) {
            return
        }
        selectedEvent = eventList[resultsTableView.clickedRow]
        
        eventDescription.stringValue = selectedEvent.descripshun
        if(eventDescription.stringValue != nil){
            eventDescription.isHidden = false
        }
        
        pictureUpperLeft.image = nil
        pictureUpperRight.image = nil
        pictureLowerLeft.image = nil
        pictureLowerRight.image = nil
        
        eventID = eventList[resultsTableView.clickedRow].id
        selectedEvent = eventList[resultsTableView.clickedRow]
        eventDescription.stringValue = selectedEvent.descripshun
        
        
        if(selectedEvent.picture1 != "") {
            picture1URL = selectedEvent.picture1
            var urlStr = URL(string: selectedEvent.picture1)
            print(urlStr)
            pictureUpperLeft.image = NSImage(contentsOf: urlStr!)
            
        }
        else {
            picture1URL = ""
            pictureUpperLeft.image = nil
        }
        if(selectedEvent.picture2 != "") {
            picture2URL = selectedEvent.picture2
            var urlStr = URL(string: selectedEvent.picture2)
            print(urlStr)
            pictureUpperRight.image = NSImage(contentsOf: urlStr!)
            
            
        }
        else {
            picture2URL = ""
            pictureUpperRight.image = nil
            
        }
        if(selectedEvent.picture3 != ""){
            picture3URL = selectedEvent.picture3
            var urlStr = URL(string: selectedEvent.picture3)
            print(urlStr)
            pictureLowerLeft.image = NSImage(contentsOf: urlStr!)
            
            
        }
        else {
            picture3URL = ""
            pictureLowerLeft.image = nil
        }
        if(selectedEvent.picture4 != "") {
            picture4URL = selectedEvent.picture4
            var urlStr = URL(string: selectedEvent.picture4)
            print(urlStr)
            pictureLowerRight.image = NSImage(contentsOf: urlStr!)
            
        }
        else {
            picture4URL = ""
            pictureLowerRight.image = nil
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        let request = "http://localhost:8081/trip/" + "\(trip_id.getID())"
        Alamofire.request(request).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            guard let info = response.result.value else {
                print("Error")
                return
            }
            
            let tripJSON = JSON(info)
            print(tripJSON)
            self.tripNameField.stringValue = tripJSON["trip"]["name"].stringValue
            //self.tripDescLabel.stringValue = tripJSON["trip"]["description"].stringValue
            let requesturl = URL(string: tripJSON["trip"]["api"].stringValue)
            let request = URLRequest(url: requesturl!)
            self.mapWebView2.mainFrame.load(request)
        }
        
        let eventRequest = "http://localhost:8081/events/" + "\(trip_id.getID())"
        Alamofire.request(eventRequest).responseJSON { response in
            
            guard let info = response.result.value else {
                print("Error")
                return
            }
            
            let eventJSON = JSON(info)
            print(eventJSON)
            
            let eventResults = eventJSON["eventList"].arrayValue
            
            self.eventList.removeAll()
            
            for i in 0...(eventResults.count-1) {
                self.eventList.append(self.convertToEvent(result: eventResults[i]))
            }
            
            // order trips here
            for i in 0...(self.eventList.count-1) {
                for j in 0...(self.eventList.count-i-1) {
                    if (j+1 >= self.eventList.count-i-1) {
                        continue
                    }
                    if (self.eventList[j].order > self.eventList[j+1].order) {
                        var temp = self.eventList[j]
                        self.eventList[j] = self.eventList[j+1]
                        self.eventList[j+1] = temp
                    }
                }
            }
            
            
            self.loadEventResults()
            
            for i in 0...(self.eventList.count-1) {
                print(self.eventList[i].getName())
            }
        }
    }
    func convertToEvent(result: JSON) -> Event {
        let event: Event = Event()
        
        event.setEvent(id: result["id"].intValue, name: result["name"].stringValue, descripshun: result["description"].stringValue, picture1: result["picture1"].stringValue, picture2: result["picture2"].stringValue, picture3: result["picture3"].stringValue, picture4: result["picture4"].stringValue, latitude: result["latitude"].stringValue, longitude: result["longitude"].stringValue, date: result["date"].stringValue, api: result["api"].stringValue, tripID: result["trip_id"].intValue, order: result["order"].intValue)
        
        return event
    }
    func loadEventResults() {
        let numRows = resultsTableView.numberOfRows
        var rangeToRemove: IndexSet = []
        rangeToRemove.insert(integersIn: 0..<numRows)
        resultsTableView.removeRows(at: rangeToRemove, withAnimation: NSTableViewAnimationOptions.effectFade)
        
        var rangeToAdd: IndexSet = []
        rangeToAdd.insert(integersIn: 0..<eventList.count)
        resultsTableView.insertRows(at: rangeToAdd, withAnimation: NSTableViewAnimationOptions.slideUp)
    }
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        //        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 220/255.0, blue: 255/255.0, alpha: 0.5)
        //        removeButtonUpperLeft.isHidden = true
        //        removeButtonUpperRight.isHidden = true
        //        removeButtonLowerLeft.isHidden = true
        //        removeButtonLowerRight.isHidden = true
        //
    }
    
    @IBAction func homeButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToHome", sender: self)
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
extension FriendTripViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return eventList.count ?? 0
    }
    
}

extension FriendTripViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let OrderCell = "OrderCellID"
        static let NameCell = "NameCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        
        // 1
        var item: Event = Event()
        if (self.eventList[row] != nil) {
            item = self.eventList[row]
        }
        else {
            return nil
        }
        
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = "\(row + 1)"
            cellIdentifier = CellIdentifiers.OrderCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.name
            if (text.characters.count == 0) {
                text = "N/A"
            }
            cellIdentifier = CellIdentifiers.NameCell
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

