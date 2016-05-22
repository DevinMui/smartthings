//
//  ViewController.swift
//  bobafetch
//
//  Created by Jesse Liang on 1/12/16.
//  Copyright © 2016 Jesse Liang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import ENSwiftSideMenu

class ViewController: UIViewController, ENSideMenuDelegate {
    
    let authKey = NSUserDefaults.standardUserDefaults().stringForKey("authTokenKey")
    let owner = NSUserDefaults.standardUserDefaults().boolForKey("owner")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("owner")
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        NSUserDefaults.standardUserDefaults().setObject("http://79dd4fa8.ngrok.io", forKey: "url")
        //NSUserDefaults.standardUserDefaults().setObject("http://192.168.1.25:3000", forKey: "url")
    }
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //VERY IMPORTANT
        
        /*if (authKey == nil) {
            self.performSegueWithIdentifier("go_to_login", sender: self)
        }*/
    }
        

    @IBAction func logOutTapped(sender: UIButton) {
        
        defaults.removeObjectForKey("authTokenKey")
        
    }
    
    @IBAction func buyScreen(sender: UIButton) {
        defaults.removeObjectForKey("teaOrder")
        defaults.removeObjectForKey("toppingOrder")
        defaults.removeObjectForKey("flavorOrder")
        defaults.removeObjectForKey("sweetnessOrder")
    }
}
    

