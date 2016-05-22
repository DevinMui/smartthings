//
//  signUpViewController.swift
//  bobafetch
//
//  Created by Jesse Liang on 1/13/16.
//  Copyright © 2016 Jesse Liang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class signUpViewController: UIViewController {
    
    @IBOutlet weak var signupLabel: UILabel!
    
    @IBOutlet weak var signUpTapped: UIButton!

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let url = NSUserDefaults.standardUserDefaults().stringForKey("url")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func things(sender: UIButton) {
        self.performSegueWithIdentifier("things", sender: self)
    }

    @IBAction func signUpTapped(sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        signUpTapped.enabled = false
        
        nameTxt.userInteractionEnabled = false
        emailTxt.userInteractionEnabled = false
        passwordTxt.userInteractionEnabled = false
        
        let name:NSString = nameTxt.text!
        let email:NSString = emailTxt.text!
        let password:NSString = passwordTxt.text!
        
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let params = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        if ( name.isEqualToString("") || email.isEqualToString("") || password.isEqualToString("")) {
            
            signUpTapped.enabled = true
            
            activityIndicator.stopAnimating()
            
            nameTxt.userInteractionEnabled = true
            emailTxt.userInteractionEnabled = true
            passwordTxt.userInteractionEnabled = true
            
            signupLabel.text = "Please fill text boxes"

        } else {
            
        Alamofire.request(.POST, url! + "/api/v1/users", parameters: params, headers: headers, encoding: .JSON)
            .responseJSON { response in
                print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                

                if (response.result.value == nil) {
                    
                    self.signUpTapped.enabled = true
                    
                    self.activityIndicator.stopAnimating()
                    
                    self.nameTxt.userInteractionEnabled = true
                    self.emailTxt.userInteractionEnabled = true
                    self.passwordTxt.userInteractionEnabled = true
                    
                    self.signupLabel.text = "Connection Error or Email Already Taken"
                    
                } else {
                    self.signUpTapped.enabled = true
                    
                    self.activityIndicator.stopAnimating()
                    
                    self.nameTxt.userInteractionEnabled = true
                    self.emailTxt.userInteractionEnabled = true
                    self.passwordTxt.userInteractionEnabled = true
                    
                    self.signupLabel.text = "Success"
                }
            }
        }

    }
}