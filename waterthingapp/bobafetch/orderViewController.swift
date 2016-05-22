//
//  orderViewController.swift
//  bobafetch
//
//  Created by Jesse Liang on 2/3/16.
//  Copyright © 2016 Jesse Liang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class orderViewController: UIViewController, UIPickerViewDelegate {
    
    let authKey = NSUserDefaults.standardUserDefaults().stringForKey("authTokenKey")
    let id = NSUserDefaults.standardUserDefaults().stringForKey("id")
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be re
    }

}
