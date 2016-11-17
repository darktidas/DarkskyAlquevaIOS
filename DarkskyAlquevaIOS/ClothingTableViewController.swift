//
//  ClothingTableViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 10/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class ClothingTableViewController: UITableViewController {

    var clothingData: [Int:Clothing]!
    
    var stateControlData: StateControlData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("informations_clothing", comment: "clothing")
        
        self.clothingData = self.stateControlData.xml.clothing
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clothingData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ClothingTableViewCell
        
        cell.titleCell.text = self.clothingData[indexPath.row+1]?.type
        cell.descriptionCell.text = self.clothingData[indexPath.row+1]?.period
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    } 
}
