//
//  HomepageViewController.swift
//  Panda
//
//  Created by Neil Kulkarni on 3/3/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class HomepageViewController: NSViewController {
    
    @IBOutlet weak var nameField: NSTextField!
    
    @IBOutlet weak var friendTable: NSTableView!
    
    @IBOutlet weak var searchField: NSTextField!
    
    
    var user: User = User()
    var friends: [User] = []
    
    
    @IBAction func addFriend(_ sender: Any) {
        let email = searchField.stringValue
        
        let friendRequest = "http://localhost:8081/search/" + email
        
        Alamofire.request(friendRequest).responseJSON { response in
            
            guard let info = response.result.value else {
                print("Error")
                return
            }
            
            let searchJSON = JSON(info)
            
            let friendID = searchJSON["id"].intValue
        
            let parameters: Parameters = [
                "user_id": self.user.getID(),
                "friend_id": friendID,
            ]
            
            Alamofire.request("http://localhost:8081/friend", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                if response.result.isSuccess {
                    guard let info = response.result.value else {
                        print("Error")
                        return
                    }
                    
                    let json = JSON(info)
                    print(json)
                }
                
                self.loadFriends()
            }
        }
        
        searchField.stringValue = ""
    }
    
    
    override func viewWillAppear() {
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = CGColor(red: 220/255.0, green: 255/255.0, blue: 240/255.0, alpha: 0.5)
        
        nameField.stringValue = user.getName()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        friendTable.delegate = self
        friendTable.dataSource = self
    
        loadFriends()
    }
    
    func convertToFriend(result: JSON) -> User {
        let friend: User = User()
        
        friend.setUser(id: result["id"].intValue, name: result["name"].stringValue, email: result["email"].stringValue, bio: result["bio"].stringValue, picture: result["picture"].stringValue)
        
        return friend
    }
    
    func loadFriendResults() {
        let numRows = friendTable.numberOfRows
        var rangeToRemove: IndexSet = []
        rangeToRemove.insert(integersIn: 0..<numRows)
        friendTable.removeRows(at: rangeToRemove, withAnimation: NSTableViewAnimationOptions.effectFade)
        
        var rangeToAdd: IndexSet = []
        rangeToAdd.insert(integersIn: 0..<friends.count)
        friendTable.insertRows(at: rangeToAdd, withAnimation: NSTableViewAnimationOptions.slideUp)
    }
    
    func loadFriends() {
        let friendRequest = "http://localhost:8081/friends/" + "\(user.getID())"
        Alamofire.request(friendRequest).responseJSON { response in
            
            guard let info = response.result.value else {
                print("Error")
                return
            }
            
            let friendJSON = JSON(info)
            print(friendJSON)
            
            let friendResults = friendJSON["info"].arrayValue
            
            self.friends.removeAll()
            
            if (friendResults.count == 0) {
                return
            }
            
            for i in 0...(friendResults.count-1) {
                self.friends.append(self.convertToFriend(result: friendResults[i]))
            }
            
            self.loadFriendResults()
        }
    }
    
    @IBAction func profileButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToProfile", sender: self)
    }
    
    @IBAction func planTripButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToPlan", sender: self)
    }
    
    @IBAction func recordTripButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToRecord", sender: self)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "idSegue", sender: self)
    }
    
    @IBAction func viewFriendProfile(_ sender: Any) {
        performSegue(withIdentifier: "idSegueToFriendProfile", sender: self)
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idSegueToProfile") {
            if let destination = segue.destinationController as? ProfileViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        else if (segue.identifier == "idSegueToPlan") {
            if let destination = segue.destinationController as? PlanViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        else if (segue.identifier == "idSegueToRecord") {
            if let destination = segue.destinationController as? RecordViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
            }
        }
        else if (segue.identifier == "idSegueToFriendProfile") {
            if let destination = segue.destinationController as? FriendProfileViewController {
                destination.user.setUser(id: user.getID(), name: user.getName(), email: user.getEmail(), bio: user.getBio(), picture: user.getPicture())
                let i = friendTable.selectedRow
                destination.friend.setUser(id: friends[i].getID(), name: friends[i].getName(), email: friends[i].getEmail(), bio: friends[i].getBio(), picture: friends[i].getPicture())
            }
        }
    }
}

extension HomepageViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.friends.count ?? 0
    }
    
}

extension HomepageViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let FriendCell = "FriendCellID"
        static let EmailCell = "EmailCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        
        // 1
        var item: User = User()
        if (self.friends[row] != nil) {
            item = self.friends[row]
        }
        else {
            return nil
        }
        
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = item.getName()
            cellIdentifier = CellIdentifiers.FriendCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.getEmail()
            if (text.characters.count == 0) {
                text = "N/A"
            }
            cellIdentifier = CellIdentifiers.EmailCell
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
