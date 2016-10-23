//
//  SlideMenuViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 21/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class SlideMenuViewController: UITableViewController{
    
    var data: [String]!
    var cellIdentifier = ["Home", "Map", "Route", "Informations", "About"]
    var stateControlData: StateControlData!
    var headerImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSlideMenuLabels()
        
        //clean
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.stateControlData = appDelegate.stateControlData
        
        headerImage = UIImage(named: "logo")
        
        self.tableView.separatorStyle = .none
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()        
    }
    
    func loadSlideMenuLabels(){
        
        let home = NSLocalizedString("slide_home", comment: "home button")
        let map = NSLocalizedString("slide_map", comment: "map button")
        let route = NSLocalizedString("slide_route", comment: "route button")
        let informations = NSLocalizedString("slide_informations", comment: "informations button")
        let about = NSLocalizedString("slide_about", comment: "about button")
        
        data = [home, map, route, informations, about]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath)
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
            imageView.image = self.headerImage
            imageView.contentMode = .scaleAspectFit
            cell.backgroundView = UIView()
            cell.backgroundView!.addSubview(imageView)
            
            cell.selectionStyle = .none
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier[indexPath.row-1], for: indexPath)
            
            cell.textLabel?.text = data[indexPath.row-1]
            print("row \(indexPath) = \(cell.textLabel?.text)")
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let slideMenuWidth: CGFloat = 260.0
        
        if  indexPath.row == 0 {
            return slideMenuWidth*(self.headerImage.size.height)/(self.headerImage.size.width)
        }else{
            return 50.0//Choose your custom row height
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMap") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! MapViewController
            targetController.stateControlData = self.stateControlData
        }
        if (segue.identifier == "toRoute") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! RouteViewController
            targetController.stateControlData = self.stateControlData
        }
        if (segue.identifier == "toInformation") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! InformationsViewController
            targetController.stateControlData = self.stateControlData
        }
    }
}
