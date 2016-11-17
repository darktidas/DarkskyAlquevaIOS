//
//  PhenomenaTableViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 09/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class PhenomenaTableViewController: UITableViewController {
    
    var phenomenasData: [Int:Phenomenon]!
    
    var stateControlData: StateControlData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("informations_phenomena", comment: "phenomena")
        
        self.phenomenasData = self.stateControlData.xml.phenomenas
        
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
        return self.phenomenasData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PhenomenaTableViewCell
        
        cell.titleCell.text = self.phenomenasData[indexPath.row+1]?.name
        cell.descriptionCell.text = self.phenomenasData[indexPath.row+1]?.period
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
