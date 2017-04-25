//
//  TripViewController.swift
//  Panda
//
//  Created by Winnie Lin on 4/5/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import MapKit
import WebKit

class TripViewController: NSViewController {
    var user: User = User()
    var trip_id: TripID = TripID()
    var eventList: [Event] = []
    var selectedEvent: Event = Event()
    var eventID: Int = -1

    @IBOutlet weak var tripNameField: NSTextField!
    @IBOutlet weak var tripDescLabel: NSTextField!
    @IBOutlet weak var mapWebView: WebView!
    
    @IBOutlet weak var resultsTableView: NSTableView!
    
    @IBOutlet weak var saveEventButton: NSButton!
    var picture1URL = ""
    var picture2URL = ""
    var picture3URL = ""
    var picture4URL = ""
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        saveEventButton.isEnabled = false
        
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
            self.tripDescLabel.stringValue = tripJSON["trip"]["description"].stringValue
            let requesturl = URL(string: tripJSON["trip"]["api"].stringValue)
            let request = URLRequest(url: requesturl!)
            self.mapWebView.mainFrame.load(request)
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
                    if (j+1 > self.eventList.count-i-1) {
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
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 220/255.0, blue: 255/255.0, alpha: 0.5)
        removeButtonUpperLeft.isHidden = true
        removeButtonUpperRight.isHidden = true
        removeButtonLowerLeft.isHidden = true
        removeButtonLowerRight.isHidden = true
        
    }
    
    @IBAction func homeButton(_ sender: Any) {
         performSegue(withIdentifier: "idSegue", sender: self)
    }
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    @IBOutlet weak var pictureUpperLeft: NSImageView!
    @IBOutlet weak var pictureUpperRight: NSImageView!
    @IBOutlet weak var pictureLowerLeft: NSImageView!
    @IBOutlet weak var pictureLowerRight: NSImageView!
    
    @IBOutlet weak var addButtonUpperLeft: NSButton!
    @IBOutlet weak var addButtonUpperRight: NSButton!
    @IBOutlet weak var addButtonLowerLeft: NSButton!
    @IBOutlet weak var addButtonLowerRight: NSButton!
    
    @IBOutlet weak var removeButtonUpperLeft: NSButton!
 
    
    @IBOutlet weak var removeButtonLowerLeft: NSButton!
    @IBOutlet weak var removeButtonUpperRight: NSButton!
 
    @IBOutlet weak var removeButtonLowerRight: NSButton!
    
    @IBAction func addPhoto1(_ sender: Any) {
        let imagePicker: NSOpenPanel = NSOpenPanel()
        imagePicker.allowsMultipleSelection = false
        imagePicker.canChooseFiles = true
        imagePicker.canChooseDirectories = false
        imagePicker.runModal()
        var imageChosen = imagePicker.url
    
        if(imageChosen != nil ){
            picture1URL = imageChosen!.absoluteString
            
            var image = NSImage(contentsOf: imageChosen!)
            pictureUpperLeft.image = image;
            
          //  user.setPicture(picture: imageChosen!.absoluteString)
          
            
  
        }
        if(pictureUpperLeft != nil){
            addButtonUpperLeft.isHidden = true;
            removeButtonUpperLeft.isHidden = false
        }
    }
    
    @IBAction func addPhoto2(_ sender: Any) {
        let imagePicker: NSOpenPanel = NSOpenPanel()
        imagePicker.allowsMultipleSelection = false
        imagePicker.canChooseFiles = true
        imagePicker.canChooseDirectories = false
        
        imagePicker.runModal()
        var imageChosen = imagePicker.url
        if(imageChosen != nil ){
            picture2URL = imageChosen!.absoluteString
            var image = NSImage(contentsOf: imageChosen!)
            pictureUpperRight.image = image;
            //  user.setPicture(picture: imageChosen!.absoluteString)
            
        }
        if(pictureUpperRight != nil){
           addButtonUpperRight.isHidden = true;
            removeButtonUpperRight.isHidden = false
        }

    }
    @IBAction func addPhoto3(_ sender: Any) {
        let imagePicker: NSOpenPanel = NSOpenPanel()
        imagePicker.allowsMultipleSelection = false
        imagePicker.canChooseFiles = true
        imagePicker.canChooseDirectories = false
        
        imagePicker.runModal()
        var imageChosen = imagePicker.url
        if(imageChosen != nil ){
            picture3URL = imageChosen!.absoluteString
            var image = NSImage(contentsOf: imageChosen!)
            pictureLowerLeft.image = image;
            //  user.setPicture(picture: imageChosen!.absoluteString)
            
        }
        if(pictureLowerLeft != nil){
           addButtonLowerLeft.isHidden = true;
            removeButtonLowerLeft.isHidden = false
        }

    }
    
   
    @IBAction func addPhoto4(_ sender: Any) {
        let imagePicker: NSOpenPanel = NSOpenPanel()
        imagePicker.allowsMultipleSelection = false
        imagePicker.canChooseFiles = true
        imagePicker.canChooseDirectories = false
        
        imagePicker.runModal()
        var imageChosen = imagePicker.url
        if(imageChosen != nil ){
            picture4URL = imageChosen!.absoluteString
            var image = NSImage(contentsOf: imageChosen!)
            pictureLowerRight.image = image;
            //  user.setPicture(picture: imageChosen!.absoluteString)
            
        }
        if(pictureLowerRight != nil){
            addButtonLowerRight.isHidden = true;
            removeButtonLowerRight.isHidden = false
        }

    }
    @IBAction func removeButtonUpperLeft(_ sender: Any) {
        pictureUpperLeft.image = nil
        addButtonUpperLeft.isHidden = false
        removeButtonUpperLeft.isHidden = true
        picture1URL = ""
        
    }
    @IBAction func removeButtonUpperRight(_ sender: Any) {
        pictureUpperRight.image = nil
        addButtonUpperRight.isHidden = false
        removeButtonUpperRight.isHidden = true
        picture2URL = ""
    }
    @IBAction func removeButtonLowerLeft(_ sender: Any) {
        pictureLowerLeft.image = nil
        addButtonLowerLeft.isHidden = false
        removeButtonLowerLeft.isHidden = true
        picture3URL = ""
    }
   
    @IBAction func removeButtonLowerRight(_ sender: Any) {
        pictureLowerRight.image = nil
        addButtonLowerRight.isHidden = false
        removeButtonLowerRight.isHidden = true
        picture4URL = ""
    }
    
    @IBOutlet weak var eventsTable: NSTableView!
    @IBAction func eventsTableRowClick(_ sender: Any) {
        if (eventsTable.clickedRow == -1) {
            return
        }
        pictureUpperLeft.image = nil
        addButtonUpperLeft.isHidden = false
        removeButtonUpperLeft.isHidden = true
        
        pictureUpperRight.image = nil
        addButtonUpperRight.isHidden = false
        removeButtonUpperRight.isHidden = true

        pictureLowerLeft.image = nil
        addButtonLowerLeft.isHidden = false
        removeButtonLowerLeft.isHidden = true

        pictureLowerRight.image = nil
        addButtonLowerRight.isHidden = false
        removeButtonLowerRight.isHidden = true
        
        eventID = eventList[eventsTable.clickedRow].id
        selectedEvent = eventList[eventsTable.clickedRow]
        eventDescriptionField.stringValue = selectedEvent.descripshun
        saveEventButton.isEnabled = true
        
        if(selectedEvent.picture1 != "") {
            picture1URL = selectedEvent.picture1
            var urlStr = URL(string: selectedEvent.picture1)
            print(urlStr)
            pictureUpperLeft.image = NSImage(contentsOf: urlStr!)
            if(pictureUpperLeft != nil){
                addButtonUpperLeft.isHidden = true;
                removeButtonUpperLeft.isHidden = false
            }
        }
        else {
            picture1URL = ""
            pictureUpperLeft.image = nil
            addButtonUpperLeft.isHidden = false
            removeButtonUpperLeft.isHidden = true
        }
        if(selectedEvent.picture2 != "") {
            picture2URL = selectedEvent.picture2
            var urlStr = URL(string: selectedEvent.picture2)
            print(urlStr)
            pictureUpperRight.image = NSImage(contentsOf: urlStr!)
            if(pictureUpperRight != nil){
                addButtonUpperRight.isHidden = true;
                removeButtonUpperRight.isHidden = false
            }

        }
        else {
            picture2URL = ""
            pictureUpperRight.image = nil
            addButtonUpperRight.isHidden = false
            removeButtonUpperRight.isHidden = true
            
        }
        if(selectedEvent.picture3 != ""){
            picture3URL = selectedEvent.picture3
            var urlStr = URL(string: selectedEvent.picture3)
            print(urlStr)
            pictureLowerLeft.image = NSImage(contentsOf: urlStr!)
            if(pictureLowerLeft != nil){
                addButtonLowerLeft.isHidden = true;
                removeButtonLowerLeft.isHidden = false
            }

        }
        else {
            picture3URL = ""
            pictureLowerLeft.image = nil
            addButtonLowerLeft.isHidden = false
            removeButtonLowerLeft.isHidden = true
            
        }
        if(selectedEvent.picture4 != "") {
            picture4URL = selectedEvent.picture4
            var urlStr = URL(string: selectedEvent.picture4)
            print(urlStr)
            pictureLowerRight.image = NSImage(contentsOf: urlStr!)
            if(pictureLowerRight != nil){
                addButtonLowerRight.isHidden = true;
                removeButtonLowerRight.isHidden = false
            }
            
        }
        else {
            picture4URL = ""
            pictureLowerRight.image = nil
            addButtonLowerRight.isHidden = false
            removeButtonLowerRight.isHidden = true
        }

    }
    
    @IBOutlet weak var eventDescriptionField: NSTextField!
    
    @IBAction func saveEventButtonClick(_ sender: Any) {
        let eventDescription = eventDescriptionField.stringValue
        print(eventID)
        print(eventDescription)
        let eventParam: Parameters = [
            "id": eventID,
            "order": selectedEvent.order,
            "description": eventDescription,
            "picture1": picture1URL,
            "picture2": picture2URL,
            "picture3": picture3URL,
            "picture4": picture4URL,
            "latitude": selectedEvent.latitude,
            "longitude": selectedEvent.longitude,
            "date": selectedEvent.date,
            "api": selectedEvent.api
        ]
        
        Alamofire.request("http://localhost:8081/event", method: .put, parameters: eventParam, encoding: JSONEncoding.default).responseJSON { response in
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
            }
        }
        
        for i in 0...(eventList.count-1) {
            if (eventList[i].id == eventID) {
                eventList[i].descripshun = eventDescription
                eventList[i].picture1 = picture1URL
                eventList[i].picture2 = picture2URL
                eventList[i].picture3 = picture3URL
                eventList[i].picture4 = picture4URL
                break
            }
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToHome") {
            if let destination = segue.destinationController as? HomepageViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
    }

    
}

extension TripViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return eventList.count ?? 0
    }
    
}

extension TripViewController: NSTableViewDelegate {
    
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
