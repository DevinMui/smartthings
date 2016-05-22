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

class usageVC: UITableViewController {
    
    
    var familyList = [String()]
    var placeList = [String()]
    var startList = [String()]
    var stopList = [String()]
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
        
        let params = [
            "id": uid
        ]
        
        Alamofire.request(.GET, url! + "/api/v1/showers", parameters: params)
            .responseJSON { response in
                print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                let JSON = response.result.value
                
                if (JSON == nil) {
                    
                    
                } else if ("\(JSON![0]["location"])" != "<null>") {
                    
                    print(JSON)
                    for (var i = 0; JSON!.count > i; i++) {
                        
                        let user = JSON![i]["user_id"] as! String
                        let start = JSON![i]["time_start"] as! String
                        let stop = JSON![i]["time_stop"] as! String
                        let place = JSON![i]["location"] as! String

                        self.familyList.append(user)
                        self.startList.append(start)
                        self.stopList.append(stop)
                        self.placeList.append(place)
                    }
                    
                }
                self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = familyList[indexPath.row] + "used" + placeList[indexPath.row] + "from" + startList[indexPath.row] + "to" + stopList[indexPath.row]
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyList.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // ---->ROW TAPPED FUNC
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let params = [
            "family_id": idList[indexPath.row]
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
        
    }*/
    
}