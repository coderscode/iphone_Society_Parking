//
//  DashboardViewController.swift
//  Building Parking
//
//  Created by Apple on 05/12/17.
//  Copyright © 2017 Vns. All rights reserved.
//

import UIKit
import ImageLoader
class DashboardViewController: UIViewController {

    //===UI And Variables==//
    @IBOutlet weak var society_name: UILabel!
    @IBOutlet weak var society_phoneno: UILabel!
    @IBOutlet weak var society_email: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var img_2_wheeler: UIImageView!
    @IBOutlet weak var img_4_wheeler: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.society_name.text="  "+retriveSharedValue(currentLevel: "society_name")
        self.society_phoneno.text=retriveSharedValue(currentLevel: "phone")
        self.society_email.text=retriveSharedValue(currentLevel: "society_email")
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let url = retriveSharedValue(currentLevel: "thumb");
        ImageLoader.request(with: url, onCompletion: { _,_,_  in });
        thumbnail.load.request(with: url, onCompletion: { _,_,_  in });
        
        let count_assign_car = retriveSharedValue(currentLevel: "assign_car");
        let count_assign_bike = retriveSharedValue(currentLevel: "assign_bike");
        
        if(count_assign_bike=="0")
        {
            img_2_wheeler.image = UIImage(named:"2_wh_us.png")
            
        }
        else
        {
            img_2_wheeler.image = UIImage(named:"2_wh_s.png")
        
        }
        if(count_assign_car=="0")
        {
            img_4_wheeler.image = UIImage(named:"4_wh_us.png")
            
        }
        else
        {
            img_4_wheeler.image = UIImage(named:"4_wh_s.png")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(_ sender: Any) {
        
        // Declare Alert
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button click...")
            self.logoutFun()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button click...")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
        // Present dialog message to user
       
    }
    
    func logoutFun()
    {
        
        
        
        storeSharedValue(currentLevel: "authkey",saveValue: "")
        PreviousScreen()
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    
    func PreviousScreen()
    {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(loginVC, animated: true, completion: nil)
    }
}
