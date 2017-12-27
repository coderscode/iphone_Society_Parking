//
//  V_DetailsViewController.swift
//  Society Parking
//
//  Created by Apple on 27/12/17.
//  Copyright © 2017 Vns. All rights reserved.
//

import UIKit

class V_DetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let v_number = ["ch-4984","ch-4985","ch-4986","ch-4987"]
    let v_model = ["pulsor-150", "Apache-180", "Splender-100", "Super Splender-125"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return v_number.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = v_list_Tableview.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = v_number[indexPath.row]
        cell?.detailTextLabel?.text = v_model[indexPath.row]
        
        return cell!
    }
    

    
    @IBOutlet weak var v_list_Tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
v_list_Tableview.delegate =  self
        v_list_Tableview.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
