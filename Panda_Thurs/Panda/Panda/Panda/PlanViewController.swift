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
    
    @IBOutlet weak var outputLabel: NSTextFieldCell!
    
    @IBOutlet weak var outputLabel2: NSTextField!
    
    @IBOutlet weak var outputLabel3: NSTextField!
    
    @IBOutlet weak var outputLabel4: NSTextField!
    
    @IBOutlet weak var outputLabel5: NSTextField!
    
    @IBOutlet weak var outputLabel6: NSTextField!
    
    @IBOutlet weak var outputLabel7: NSTextField!
    
    @IBOutlet weak var outputLabel8: NSTextField!
    
    @IBOutlet weak var outputLabel9: NSTextField!
    
    @IBOutlet weak var outputLabel10: NSTextField!
    
    
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
        var tempBusiness:Business = Business()                              //lolololololololololololololol
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
                //                print(info)
                let json = JSON(info)
                //                print(json)
                let businesses = json["businesses"].arrayValue
                
                var businessList: [Business] = []
                
                for i in 0...9 {
                    businessList.append(self.convertToBusiness(businessObject: businesses[i]))
                    
                }
                self.outputLabel.stringValue = self.toString(item: businessList[0])
                self.outputLabel2.stringValue = self.toString(item: businessList[1])
                self.outputLabel3.stringValue = self.toString(item: businessList[2])
                self.outputLabel4.stringValue = self.toString(item: businessList[3])
                self.outputLabel5.stringValue = self.toString(item: businessList[4])
                self.outputLabel6.stringValue = self.toString(item: businessList[5])
                self.outputLabel7.stringValue = self.toString(item: businessList[6])
                self.outputLabel8.stringValue = self.toString(item: businessList[7])
                self.outputLabel9.stringValue = self.toString(item: businessList[8])
                self.outputLabel10.stringValue = self.toString(item: businessList[9])
                 //               let business = businesses[0]
                //                let text = business["name"].stringValue
                //                print("The first business is " + text)
                //
                 //              print(business)
                //
                //                self.categoryField.stringValue = business["name"].stringValue
                //
                
                
                // let locationD = business["location"]
                
                //self.locationLabel.text = "\(locationD["address1"].stringValue), \(locationD["city"].stringValue)"
                
                // let imageUrl = URL(string: business["image_url"].stringValue)
                
                // let imageRequest = URLRequest(url: imageUrl!)
                
                //                let session = URLSession(configuration: .default)
                //
                //                session.dataTask(with: imageRequest, completionHandler: { (data, response, error) in
                //                    guard let image = data else {
                //                        print(error?.localizedDescription ?? "error")
                //                        return
                //                    }
                //                    self.pictureView.image = UIImage(data: image)
                //                }).resume()
            }
        }
        
    }
    
    @IBOutlet weak var searchButton: NSButton!
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
