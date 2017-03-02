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
    
    @IBOutlet weak var printPlaces: NSTextField!
    var token:String?
    
    let clientID = "2xtPDNRnr_toiEhI1V0W9w"
    
    let secret = "rt89Skh0SLJ2hfz9otXl5GfnrhusMhvt9I6bvepdYKkzcC7mbxmOp9fzfHbee2KJ"
    
    let baseURL = "https://api.yelp.com/oauth2/token"
    
    let searchURL = "https://api.yelp.com/v3/businesses/search"
    
     //   let location = "West Lafayette, IN"
    var term:String?
    var location:String?
    //var term = categoryField.stringValue

    @IBAction func searchButton(_ sender: NSButton) {
        term = categoryField.stringValue
        location = cityField.stringValue
        getToken()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
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
                    var tempBusiness = businesses[i]
                    businessList[i].name = tempBusiness["name"].stringValue
                    businessList[i].rating = tempBusiness["rating"].double
//                    let categories = json["categories"].arrayValue
//                    topCategory = categories[0]
                    businessList[i].category = tempBusiness["categories.[0].title"].stringValue
                    businessList[i].price = tempBusiness["price"].stringValue
                    businessList[i].url = tempBusiness["url"].stringValue
                    businessList[i].latitude = tempBusiness["coordinates.latitude"].double
                    businessList[i].longitude = tempBusiness["coordinates.longitude"].double
                    

                }
                
//                let business = businesses[0]
//                let text = business["name"].stringValue
//                print("The first business is " + text)
//                
//                print(business)
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
}
