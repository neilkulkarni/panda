//
//  PlanViewController.swift
//  Panda
//
//  Created by Aarti Panda on 3/2/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class PlanViewController: NSViewController {

    @IBOutlet weak var categoryField: NSTextField!
    @IBOutlet weak var cityField: NSTextField!
    var token:String?
    
    
    @IBOutlet weak var resultsTableView: NSTableView!
    
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
    
    @IBOutlet weak var tripDescriptionField: NSTextFieldCell!
    @IBOutlet weak var tripNameField: NSTextField!
    @IBOutlet weak var tripDescriptionErrorLabel: NSTextField!
    
    var tripDesc:String?
    var tripName:String?
    
    @IBAction func exitTripDescription(_ sender: Any) {
        tripDesc = tripDescriptionField.stringValue
        
        if ((self.tripDesc?.characters.count)! > 160) {
            tripDescriptionErrorLabel.isHidden = false
        }
        else {
            tripDescriptionErrorLabel.isHidden = true
        }
    }
    
    @IBAction func selectLocationButton(_ sender: Any) {
        let row = resultsTableView.selectedRow
        if (row >= 0 || row <= 10) {
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
    
    
    var businessList: [Business] = []
    var selectedList: [Business] = []
    var user: User = User()
    
    
    
    let clientID = "2xtPDNRnr_toiEhI1V0W9w"
    let secret = "rt89Skh0SLJ2hfz9otXl5GfnrhusMhvt9I6bvepdYKkzcC7mbxmOp9fzfHbee2KJ"
    let baseURL = "https://api.yelp.com/oauth2/token"
    let searchURL = "https://api.yelp.com/v3/businesses/search"
    
    //   let location = "West Lafayette, IN"
    var term:String?
    var location:String?
    //var term = categoryField.stringValue
    
    @IBAction func actualSearchButton(_ sender: Any) {
        term = categoryField.stringValue
        
        location = cityField.stringValue
        if(location!.isEmpty){
            location = "West Lafayette, IN"
        }
        getToken()
    }
    func getToken() {
        Alamofire.request(baseURL, method: .post, parameters: ["grant_type" : "client_credentials", "client_id" : clientID, "client_secret" : secret], encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isSuccess {
                guard let info = response.result.value else {
                    print("Error")
                    return
                }
                print(info)
                let json = JSON(info)
                print(json)
                
                self.token = json["access_token"].stringValue
                self.loadBusiness()
                
            }
        }
    }
    func convertToBusiness(businessObject: JSON) -> Business{
        let tempBusiness:Business = Business()                             //lolololololololololololololol
        tempBusiness.image = NSImage(byReferencingFile: businessObject["image_url"].stringValue)
        tempBusiness.name = businessObject["name"].stringValue
        tempBusiness.rating = businessObject["rating"].double
        tempBusiness.category = businessObject["categories.[0].title"].stringValue
        tempBusiness.price = businessObject["price"].stringValue
        tempBusiness.url = businessObject["url"].stringValue
        tempBusiness.latitude = businessObject["coordinates.latitude"].double
        tempBusiness.longitude = businessObject["coordinates.longitude"].double
        return tempBusiness
        
    }
    
    func toString(item: Business) ->String{
        var businessString1 = item.name! + ", Category: " + item.category!
        var businessString2 = ", Rating: \(item.rating)" + ", Price: " + item.price!
        var businessString = businessString1 + businessString2
        return businessString
    }
    
    func loadBusiness() {
        
        
        Alamofire.request(searchURL, method: .get, parameters: ["term" : term, "location": location], encoding: URLEncoding.default, headers: ["Authorization" : "Bearer \(token!)"]).validate().responseJSON { response in
            if response.result.isSuccess {
                guard let info = response.result.value else {
                    print("Error")
                    return
                }

                let json = JSON(info)

                let businesses = json["businesses"].arrayValue
                
                self.businessList.removeAll()
                
                for i in 0...(businesses.count - 1) {
                    self.businessList.append(self.convertToBusiness(businessObject: businesses[i]))
                    
                }
                
               self.loadBusinessResults()
            }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
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

extension PlanViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return businessList.count ?? 0
    }
    
}

extension PlanViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "NameCellID"
        static let CategoryCell = "CategoryCellID"
        static let PriceCell = "PriceCellID"
        static let RatingCell = "RatingCellID"
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
        print(self.toString(item: item))
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = item.name!
            cellIdentifier = CellIdentifiers.NameCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.category!
            if (text.characters.count == 0) {
                text = categoryField.stringValue.capitalized
            }
            cellIdentifier = CellIdentifiers.CategoryCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = item.price!
            cellIdentifier = CellIdentifiers.PriceCell
        } else if tableColumn == tableView.tableColumns[3] {
            text = "\(item.rating!)"
            cellIdentifier = CellIdentifiers.RatingCell
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


