//
//  stripeViewController.swift
//  bobafetch
//
//  Created by Jesse Liang on 2/25/16.
//  Copyright © 2016 Jesse Liang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Stripe

let authToken = NSUserDefaults.standardUserDefaults().stringForKey("authTokenKey")

let url = NSUserDefaults.standardUserDefaults().stringForKey("url")

let id = NSUserDefaults.standardUserDefaults().integerForKey("boba_id")

let cost = NSUserDefaults.standardUserDefaults().integerForKey("cost")

let defaults = NSUserDefaults.standardUserDefaults()

class stripeViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cardText: UITextField!
    @IBOutlet weak var cvcText: UITextField!
    @IBOutlet weak var monthText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    /*@IBAction func save(sender: UIButton) {
        if let card = paymentTextField.card {
            STPAPIClient.sharedClient().createTokenWithCard(card) { (token, error) -> Void in
                if let error = error  {
                    handleError(error)
                }
                else if let token = token {
                    createBackendChargeWithToken(token, id) { status in
    
                    }
                }
            }
        }
    }*/
    
    @IBAction func textFieldButton(sender: UIButton) {

        print(id)
        
        let card:NSString = cardText.text!
        let month:NSString = monthText.text!
        let year:NSString = yearText.text!
        let cvc:NSString = cvcText.text!
        
        if (card.isEqualToString("") || month.isEqualToString("") || year.isEqualToString("") || cvc.isEqualToString("")) {
            
            label.text = "Please fill out all boxes"
        
        } else {
            let stripeCard = STPCardParams()
            stripeCard.cvc = self.cvcText.text
            stripeCard.number = self.cardText.text
            let expYear = UInt(Int(yearText.text!)!)
            stripeCard.expYear = expYear
            let expMonth = UInt(Int(monthText.text!)!)
            stripeCard.expMonth = expMonth
            STPAPIClient.sharedClient().createTokenWithCard(stripeCard) { (token, error) -> Void in
                if let error = error  {
                    print(error)
                }
                else if let token = token {
                    print(token)
                    self.createBackendChargeWithToken(token, id: id) { status in
                            
                    }
                }
            }

        }
    }
    
    func createBackendChargeWithToken(token: STPToken, id: Int,completion: PKPaymentAuthorizationStatus -> ()) {
        print("in function backendcharge")
        
        let headers : [String : String] = [
            "Authorization": "Token token=" + authToken!,
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let params = [
            "stripe_token": String(token),
            "stripe_customer": ""
        ]
        
        
        
        Alamofire.request(.PUT, url! + "/api/v1/bobas/" + String(id) + "/update_paid", parameters: params, headers: headers, encoding: .JSON)
            .responseJSON { response in
                if response.result.value == nil {
                    print("Nothing")
                } else if let JSON = response.result.value {
                    let date = NSDate()
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([ .Hour, .Minute, .Second, .Weekday], fromDate: date)
                    let hour = components.hour
                    let minute = components.minute
                    let weekday = components.weekday
                    if(weekday == 1){ // monday
                        if (hour < 12 || (hour == 11 && minute < 20)) { // before 11:30
                            self.scheduleNotification(11, minute: 35); // end of 3rd
                        } else if (hour < 13 || (hour == 12 && minute < 5)) { // before 12:15
                            self.scheduleNotification(12, minute: 30); // end of 4th
                        } else if (hour < 13 || (hour == 12 && minute <= 50)) { // before 1
                            self.scheduleNotification(13, minute: 15); // end of 5th
                        } else if (hour < 15 || (hour == 14 && minute < 35)) { // before 2:45
                            self.scheduleNotification(14, minute: 0); // end of 6th
                        } else if(hour < 15 || (hour == 14 && minute < 20)) { // before 2:30
                            self.scheduleNotification(14, minute: 45) // end of 7th
                        } else if (hour < 16 || (hour == 15 && minute < 5)) { // before 3:15
                            self.scheduleNotification(15, minute: 30); // end of 78th
                        } else {
                            // buy period over
                            // toast it
                        }
                    } else if(weekday == 2 || weekday == 4){ // tuesday and thursday
                        if (hour < 12 || (hour == 11 && minute < 15)) {
                            self.scheduleNotification(11, minute: 40);
                        } else if (hour < 13 || (hour == 12 && minute < 5)) {
                            self.scheduleNotification(12, minute: 30);
                        } else if (hour < 14 || (hour == 13 && minute < 10)) {
                            self.scheduleNotification(13, minute: 35);
                        } else if (hour < 15 || (hour == 14 && minute < 0)) {
                            self.scheduleNotification(14, minute: 25);
                        } else if (hour < 16 || (hour == 15 && minute < 5)) {
                            self.scheduleNotification(15, minute: 30);
                        } else {
                            // buy period over
                            // toast it
                        }

                    } else if(weekday == 3 || weekday == 5){ // wednesday and friday
                        if (hour < 12 || (hour == 11 && minute < 15)) {
                            self.scheduleNotification(11, minute: 40);
                        } else if (hour < 13 || (hour == 12 && minute < 20)) {
                            self.scheduleNotification(12, minute: 45);
                        } else if (hour < 14 || (hour == 13 && minute < 10)) {
                            self.scheduleNotification(13, minute: 35);
                        } else if (hour < 15 || (hour == 14 && minute < 15)) {
                            self.scheduleNotification(14, minute: 40);
                        } else if (hour < 16 || (hour == 15 && minute < 5)) {
                            self.scheduleNotification(15, minute: 30);
                        } else {
                            // buy period over
                            // toast it
                        }

                    } else {
                        // its a weekend
                    }

                }
        }

    }
    
    func scheduleNotification(hour: Int, minute: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarComponents = NSDateComponents()
        calendarComponents.hour = hour
        calendarComponents.second = 0
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
