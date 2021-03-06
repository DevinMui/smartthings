//
//  ownerVC.swift
//  bobafetch
//
//  Created by Jesse Liang on 3/8/16.
//  Copyright © 2016 Jesse Liang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class joinVC: UITableViewController {
    
    
    var familyList = [String()]
    var idList = [Int()]
    var count = Int()
    
    let url = NSUserDefaults.standardUserDefaults().stringForKey("url")
    let authKey = NSUserDefaults.standardUserDefaults().stringForKey("authTokenKey")
    let uid = NSUserDefaults.standardUserDefaults().integerForKey("id")
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
    }
    
    func get(){
        
        familyList.removeAll()
        
        Alamofire.request(.GET, url! + "/api/v1/families")
            .responseJSON { response in
                print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                
                if (response.result.value == nil) {
                    
                    
                } else if (response.result.value != nil) {

                    let JSON = response.result.value
                    for (var i = 0; JSON!.count > i; i++) {
                        
                        let family = JSON![i]["name"] as! String
                        let id = JSON![i]["id"] as! Int
                        self.familyList.append(family)
                        self.idList.append(id)
                    }

                }
                self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = familyList[indexPath.row]//familyList[indexPath.row]
        
    
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyList.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        let famid = idList[indexPath.row] + 1
        let params = [
            "family_id": famid
        ]
        
        
        Alamofire.request(.PUT, url! + "/api/v1/users/\(uid)", parameters: params, headers: headers, encoding: .JSON)
            .responseJSON { response in
                print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                
                if (response.result.value == nil) {
                    
                } else if (response.result.value != nil) {
                    print(response.result.value)
                }
        }

    }

}