//
//  ViewController.swift
//  Building Parking
//
//  Created by Apple on 22/11/17.
//  Copyright © 2017 Vns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    

   

    @IBAction func submitNew(_ sender: Any) {
        testtext.text=email.text
//        print (email.text ?? <#default value#>)
        
    }
    
    @IBOutlet weak var testtext: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBAction func submitClick(_ sender: Any) {
        //click button listener
//        print (email.text ?? <#default value#>)
    }
    
    
   
}

