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
    
    let url = NSUserDefaults.standardUserDefaults().stringForKey("url")
    let authKey = NSUserDefaults.standardUserDefaults().stringForKey("authTokenKey")
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        
        
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.text = "things"
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    @IBAction func refreshBUtton(sender: AnyObject) {
    }
}