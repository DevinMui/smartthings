//
//  purchaseViewController.swift
//  bobafetch
//
//  Created by Jesse Liang on 2/8/16.
//  Copyright © 2016 Jesse Liang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class purchaseViewController: UIViewController {
    
    @IBOutlet weak var orderTeaLabel: UILabel!
    @IBOutlet weak var orderTeaPriceLabel: UILabel!
    @IBOutlet weak var orderToppingLabel: UILabel!
    @IBOutlet weak var orderToppingPriceLabel: UILabel!
    @IBOutlet weak var orderFlavorLabel: UILabel!
    @IBOutlet weak var orderFlavorPriceLabel: UILabel!
    @IBOutlet weak var orderOtherLabel: UILabel!
    @IBOutlet weak var orderOtherPriceLabel: UILabel!
    
    let url = NSUserDefaults.standardUserDefaults().stringForKey("url")
    
    var toppingOrderArray = [String]()
    var flavorOrderArray = [String]()
    
    var flavorOrderString1 = String()
    var flavorOrderString2 = String()
    var flavorOrderString3 = String()
    var toppingOrderString1 = String()
    var toppingOrderString2 = String()
    var toppingOrderString3 = String()
    var toppingOrderString4 = String()
    var toppingOrderString5 = String()
    
    var teaOrder = NSUserDefaults.standardUserDefaults().objectForKey("teaOrder")
    var sweetnessOrder = NSUserDefaults.standardUserDefaults().objectForKey("sweetnessOrder")
    var toppingOrder = NSUserDefaults.standardUserDefaults().arrayForKey("toppingOrder")
    var flavorOrder = NSUserDefaults.standardUserDefaults().arrayForKey("flavorOrder")
    var milkBool = NSUserDefaults.standardUserDefaults().stringForKey("milkBool")
    var slushieBool = NSUserDefaults.standardUserDefaults().stringForKey("slushieBool")
    var smoothieBool = NSUserDefaults.standardUserDefaults().stringForKey("smoothieBool")
    var largeBool = NSUserDefaults.standardUserDefaults().stringForKey("largeBool")
    var premiumTea = NSUserDefaults.standardUserDefaults().stringForKey("premiumTea")
    var authKey = NSUserDefaults.standardUserDefaults().stringForKey("authTokenKey")
    var toppingCost = NSUserDefaults.standardUserDefaults().doubleForKey("toppingCost")
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var flavors:[AnyObject] = []
        var toppings:[AnyObject] = []
        
        for i in flavorOrder! {
            let name = ["name": i]
            flavors.append(name)
        }
        
        for i in toppingOrder! {
            let name = ["name": i]
            toppings.append(name)
        }
        
        print(flavors)
        print(toppings)
        
        let params = [
            "boba": [
                "tea": teaOrder! as AnyObject,
                "sweetness": sweetnessOrder! as AnyObject,
                "milk": milkBool!,
                "smoothie": smoothieBool!,
                "slushie": slushieBool!,
                "large": largeBool!,
                "premium_tea": premiumTea!,
            ],
            "flavors": flavors,
            "toppings": toppings
        ]
        
        print(params)
        
        let authToken = "Token token=" + authKey!
        
        let headers : [String : String] = [
            "Authorization": authToken,
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]

        /*Alamofire.request(.POST, url! + "/api/v1/bobas", parameters: params as? [String : AnyObject], headers: headers, encoding: .JSON)
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    //print(JSON)
                }
        }*/
    }
}