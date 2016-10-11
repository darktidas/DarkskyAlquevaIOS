//
//  SlideMenuViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 21/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class SlideMenuViewController: UITableViewController {
    
    var data = ["Home", "Map", "Route", "Informations", "About"]
    var cellIdentifier = ["home", "map", "route", "informations", "about"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "headerMenuViewCell")
            /*
            let image : UIImage = UIImage(named: "logo")!
            print("The loaded image: \(image)")
            cell.imageView?.image = image*/
            /*
            let backGroundImage:UIImageView = UIImageView()
            
            backGroundImage.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
            
            print("cell bounds = \(cell.bounds)")
            
            let image: UIImage = UIImage(named: "logo")!
            
            print("image bounds = \(image.size)")
            
            
            
            backGroundImage.image = image
            print("background image bounds = \(backGroundImage.bounds)")
            backGroundImage.contentMode = .scaleAspectFit
            
            cell.backgroundView = backGroundImage
            
            
            
            print("cell bounds after = \(backGroundImage.bounds)")*/
            
            
            let image: UIImage = UIImage(named: "logo")!
            cell.imageView?.image = image
            //cell.imageView?.contentMode = .scaleAspectFit
            
            
            return cell
        }
        else {
            //let cell = tableView.dequeueReusableCell(withIdentifier: "bodyCell", for: indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: self.data[indexPath.row-1], for: indexPath)
    
            
            cell.textLabel?.text = data[indexPath.row-1]
            print("row \(indexPath) = \(cell.textLabel?.text)")
            
            
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50.0;//Choose your custom row height
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }*/
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
