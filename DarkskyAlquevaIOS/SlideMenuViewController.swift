//
//  SlideMenuViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 21/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

//implementar a logica da legenda de acordo com os tipos
//loading de imagem - done
//moon calculation - today legend ----- passado
//icon launch sizes
//bug no rotate de imagens - 
//slide menu header cell user interection - done
//disable share no network - done

//bug slide menu - done
//imagem manter aspect ratio e altura - done
//mudar a lupa para o i - done
//ver ajuda em espanhol linguas - done
//load info from xml if it exists - done
//bug pan gesture recognizer - done
//bug map movement - done
//bug popover - done
//check internet conection - done
//moon calculations rights - make reference on report - done

//resume app after change language


class SlideMenuViewController: UITableViewController{
    
    var data: [String]!
    var cellIdentifier = ["Home", "Map", "Route", "Informations", "About"]
    var stateControlData: StateControlData!
    var headerImage: UIImage!
    var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSlideMenuLabels()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.stateControlData = appDelegate.stateControlData
        
        headerImage = UIImage(named: "logo")
        
        self.tableView.separatorStyle = .none
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
         let screenSize: CGRect = UIScreen.main.bounds
         var largerSide: CGFloat!
         var smallerSide: CGFloat!
         
         if screenSize.width > screenSize.height{
         largerSide = screenSize.width
         smallerSide = screenSize.height
         }else{
         largerSide = screenSize.height
         smallerSide = screenSize.width
         }
         var testFrame : CGRect!
         if UIDevice.current.orientation.isLandscape {
         testFrame = CGRect(x: 0,y: 44, width: largerSide,height: smallerSide-44)
         }else{
         testFrame = CGRect(x: 0,y: 64, width: smallerSide,height: largerSide-64)
         }
         
         testView = UIView(frame: testFrame)
         self.revealViewController().frontViewController.view.addSubview(testView)
         testView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        testView.removeFromSuperview()
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        let screenSize: CGRect = UIScreen.main.bounds
        var largerSide: CGFloat!
        var smallerSide: CGFloat!
        
        if screenSize.width > screenSize.height{
            largerSide = screenSize.width
            smallerSide = screenSize.height
        }else{
            largerSide = screenSize.height
            smallerSide = screenSize.width
        }
        if (toInterfaceOrientation.isLandscape) {
            print(UIDevice.current.orientation.isLandscape)
            testView.frame = CGRect(x: 0,y: 44, width: largerSide,height: smallerSide)
        }
        else {
            print(UIDevice.current.orientation.isPortrait)
            testView.frame = CGRect(x: 0,y: 64, width: smallerSide,height: largerSide)
        }
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
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count+1
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            cell.setSelected(true, animated: false)
            self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
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
            cell.isUserInteractionEnabled = false
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier[indexPath.row-1], for: indexPath)
            
            cell.textLabel?.text = data[indexPath.row-1]
            cell.textLabel?.textColor = UIColor.white
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.darkGray
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let slideMenuWidth: CGFloat = 260.0
        
        if  indexPath.row == 0 {
            return slideMenuWidth*(self.headerImage.size.height)/(self.headerImage.size.width)
        }else{
            return 50.0
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
