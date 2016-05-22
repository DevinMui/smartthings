//
//  LoginViewController.swift
//  bobafetch
//
//  Created by Jesse Liang on 1/13/16.
//  Copyright © 2016 Jesse Liang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var signUpTapped: UIButton!
    @IBOutlet weak var logInTapped: UIButton!
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var authToken: String!
    
    let url = NSUserDefaults.standardUserDefaults().stringForKey("url")
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    


    @IBAction func logInTapped(sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        signUpTapped.enabled = false
        logInTapped.enabled = false
        
        emailTxt.userInteractionEnabled = false
        passwordTxt.userInteractionEnabled = false
        
        let email:NSString = emailTxt.text!
        let password:NSString = passwordTxt.text!
        
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let params = [
            "email": email,
            "password": password
        ]
        
        if (email.isEqualToString("") || password.isEqualToString("")) {
            
            signUpTapped.enabled = true
            logInTapped.enabled = true
            
            activityIndicator.stopAnimating()
            
            loginLabel.text = "Please fill text boxes"
            
            emailTxt.userInteractionEnabled = true
            passwordTxt.userInteractionEnabled = true
            
        } else {
            
            Alamofire.request(.POST, url! + "/api/v1/sessions", parameters: params, headers: headers, encoding: .JSON)
                .responseJSON { response in
                    print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    
                    if response.result.value == nil {
                        
                        self.signUpTapped.enabled = true
                        self.logInTapped.enabled = true
                        
                        self.activityIndicator.stopAnimating()
                        
                        self.loginLabel.text = "Bad Credentials or Connection Error"
                        
                        self.emailTxt.userInteractionEnabled = true
                        self.passwordTxt.userInteractionEnabled = true
                        
                    } else if let JSON = response.result.value {
                        
                        self.signUpTapped.enabled = true
                        self.logInTapped.enabled = true
                        
                        self.activityIndicator.stopAnimating()
                        
                        let authToken = JSON["auth_token"]
                        let id = JSON["id"]
                        
                        self.emailTxt.userInteractionEnabled = true
                        self.passwordTxt.userInteractionEnabled = true
                        
                        self.defaults.setObject(authToken, forKey: "authTokenKey")
                        self.defaults.setObject(id, forKey: "id")
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
        
                    }
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // schedule notifications
    /*
    
    SOME CODE FROM ANDROID
    
    NOTE SOME TIMES SHOULD NOT BE INCLUDED AS TPUMPS OPEN AND CLOSE TIMES ARE DIFFERENT FROM LOWELLS
    
    switch (day) {
    // monday
    case 2:
    if (hour < 10 && minute < 40) {
    scheduleNotification(getNotification(), 9, 55);
    } else if (hour < 11 && minute < 25) {
    scheduleNotification(getNotification(), 10, 40);
    } else if (hour < 12 && minute < 30) {
    scheduleNotification(getNotification(), 11, 45);
    } else if (hour < 13 && minute < 15) {
    scheduleNotification(getNotification(), 12, 30);
    } else if (hour < 14 && minute < 0) {
    scheduleNotification(getNotification(), 13, 15);
    } else if (hour < 14 && minute < 45) {
    scheduleNotification(getNotification(), 14, 0);
    } else if (hour < 15 && minute < 30) {
    scheduleNotification(getNotification(), 15, 45);
    } else if (hour < 16 && minute < 15) {
    scheduleNotification(getNotification(), 16, 30);
    } else {
    // buy period over
    // toast it
    }
    break;
    // tuesday and thursday
    case 3:
    case 5:
    if (hour < 9 && minute < 5) {
    scheduleNotification(getNotification(), 8, 20);
    } else if (hour < 10 && minute < 10) {
    scheduleNotification(getNotification(), 9, 25);
    } else if (hour < 11 && minute < 20) {
    scheduleNotification(getNotification(), 10, 35);
    } else if (hour < 12 && minute < 25) {
    scheduleNotification(getNotification(), 11, 40);
    } else if (hour < 13 && minute < 15) {
    scheduleNotification(getNotification(), 12, 30);
    } else if (hour < 14 && minute < 20) {
    scheduleNotification(getNotification(), 13, 35);
    } else if (hour < 15 && minute < 10) {
    scheduleNotification(getNotification(), 14, 25);
    } else if (hour < 16 && minute < 15) {
    scheduleNotification(getNotification(), 15, 30);
    } else {
    // buy period over
    // toast it
    }
    break;
    // wednesday and friday
    case 4:
    case 6:
    if (hour < 9 && minute < 20) {
    scheduleNotification(getNotification(), 8, 35);
    } else if (hour < 10 && minute < 10) {
    scheduleNotification(getNotification(), 9, 25);
    } else if (hour < 11 && minute < 35) {
    scheduleNotification(getNotification(), 10, 50);
    } else if (hour < 12 && minute < 25) {
    scheduleNotification(getNotification(), 11, 40);
    } else if (hour < 13 && minute < 30) {
    scheduleNotification(getNotification(), 12, 45);
    } else if (hour < 14 && minute < 20) {
    scheduleNotification(getNotification(), 13, 35);
    } else if (hour < 15 && minute < 25) {
    scheduleNotification(getNotification(), 14, 40);
    } else if (hour < 16 && minute < 15) {
    scheduleNotification(getNotification(), 15, 30);
    } else {
    // buy period over
    // toast it
    }
    */
    
    func scheduleNotification(hour: Int, minute: Int, second: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarComponents = NSDateComponents()
        calendarComponents.hour = hour
        calendarComponents.second = second
        calendarComponents.minute = minute
        calendar.timeZone = NSTimeZone.defaultTimeZone()
        let dateToFire = calendar.dateFromComponents(calendarComponents)
        let notification:UILocalNotification = UILocalNotification()
        notification.alertAction = "Pick up your drink!"
        notification.alertBody = "Your drink has arrived!"
        notification.fireDate = dateToFire
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

}
