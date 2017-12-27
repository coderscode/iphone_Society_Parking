//
//  ViewController.swift
//  Building Parking
//
//  Created by Apple on 22/11/17.
//  Copyright © 2017 Vns. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD
class ViewController: UIViewController,UITextFieldDelegate {

    //===override==//
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.delegate=self
        self.password.delegate=self
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    //===override==//
    override func viewDidAppear(_ animated: Bool) {
        if(retriveSharedValue(currentLevel: "auth_key").count>0)
        {
              NextScreen()
        }
    }
    //===override==//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //===override==//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //===Bind with Submit button==//
    @IBAction func submit(_ sender: Any) {
        
        print (email.text)
        print (password.text)
        
        if(email.text=="" || password.text=="")
        {
            Toast("Please fill up all the fields").show(self)
            
        }
        else
        {
            let comment: [String:AnyObject] = [
                "email": email.text as AnyObject,
                "password": password.text as AnyObject,
                "fcm_key": "asdfasfsadfadsfsdf" as AnyObject
            ]
            getLoginData(url: baseURL,comment: comment)
        }
        
    }
    
    //===UI And Variables==//
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let baseURL = "http://vnsparking-env.ahgftwjyr4.ap-south-1.elasticbeanstalk.com/AllUserAPI?api_type=FlatOwnerLogin"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    
    
    func textFieldShouldReturn(_textField:UITextField)->Bool
    {
        _textField.resignFirstResponder()
        
        return (true)
    }
    
    //===Login credendtials check with server==//
    func getLoginData(url: String,comment: [String:AnyObject]) {
    SVProgressHUD.show()
            Alamofire.request(url, method: .post, parameters: comment)
                .responseJSON { response in
                    if response.result.isSuccess {
                        SVProgressHUD.dismiss()
                        print("Sucess! Got the weather data")
                        let weatherJSON : JSON = JSON(response.result.value!)
                        print(weatherJSON)
                        self.updateLoginData(json: weatherJSON)
                    
                    } else {
                        SVProgressHUD.dismiss();                   print("Error: \(String(describing: response.result.error))")
                            }
                }
    
        }
    
    //===Convert Json data into String data==//
    func jsonToString(json: AnyObject)-> String{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            
            return (convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        return ""
    }
    
    
    //===JSON Parsing==//
    func updateLoginData(json : JSON) {
        if let bitcoinResult = json["status"].bool
        {
            if (bitcoinResult==true)
            { //Toast("Success").show(self)
                
                storeSharedValue(currentLevel: "assign_car", saveValue:json["Flat_Owner_Data"]["assign_car"].stringValue)
                storeSharedValue(currentLevel: "auth_key", saveValue:json["Flat_Owner_Data"]["auth_key"].stringValue)
                storeSharedValue(currentLevel: "thumb", saveValue:json["Flat_Owner_Data"]["thumb"].stringValue)
                storeSharedValue(currentLevel: "flat_type", saveValue:json["Flat_Owner_Data"]["flat_type"].stringValue)
                storeSharedValue(currentLevel: "society_name", saveValue:json["Flat_Owner_Data"]["society_name"].stringValue)
                storeSharedValue(currentLevel: "society_phone_no", saveValue:json["Flat_Owner_Data"]["society_phone_no No"].stringValue)
                storeSharedValue(currentLevel: "last_name", saveValue:json["Flat_Owner_Data"]["last_name"].stringValue)
                storeSharedValue(currentLevel: "Total car", saveValue:json["Flat_Owner_Data"]["Total car"].stringValue)
                storeSharedValue(currentLevel: "society_email", saveValue:json["Flat_Owner_Data"]["society_email"].stringValue)
                storeSharedValue(currentLevel: "assign_bike", saveValue:json["Flat_Owner_Data"]["assign_bike"].stringValue)
                storeSharedValue(currentLevel: "flat_no", saveValue:json["Flat_Owner_Data"]["flat_no"].stringValue)
                storeSharedValue(currentLevel: "Total_Bike", saveValue:json["Flat_Owner_Data"]["Total_Bike"].stringValue)
                storeSharedValue(currentLevel: "phone", saveValue:json["Flat_Owner_Data"]["phone"].stringValue)
                storeSharedValue(currentLevel: "society_address", saveValue:json["Flat_Owner_Data"]["society_address"].stringValue)
                storeSharedValue(currentLevel: "id", saveValue:json["Flat_Owner_Data"]["id"].stringValue)
                storeSharedValue(currentLevel: "first_name", saveValue:json["Flat_Owner_Data"]["first_name"].stringValue)
                storeSharedValue(currentLevel: "email", saveValue:json["Flat_Owner_Data"]["email"].stringValue)
               
                NextScreen()
  
            }
            else
            {
            Toast("Email or password doesn't matched").show(self)
            }
            
        }
        else
        {
            Toast("Unavailable").show(self)
         
        }
        
    }
    
    //===Send to Home Screen==//
    func NextScreen()
    {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.present(loginVC, animated: true, completion: nil)
    }
    //===Store value on Sharedpref==//
    func storeSharedValue(currentLevel: String, saveValue: String)
    {
        let preferences = UserDefaults.standard
        let currentLevelKey = currentLevel
         // store string value
        preferences.set(saveValue, forKey: currentLevelKey)
         //  Save to disk
        let didSave = preferences.synchronize()
         if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    }
    
    //===retrive value from Sharedpref==//
    func retriveSharedValue(currentLevel: String)->String
    {
         let preferences = UserDefaults.standard
         let currentLevelKey = currentLevel
         if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
        } else {
              return preferences.object(forKey: currentLevelKey) as! String
        }
        
        
        return ""
    }
    
}

