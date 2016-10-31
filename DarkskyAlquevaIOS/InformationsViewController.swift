//
//  InformationsViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 24/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class InformationsViewController: UIViewController {
    
    @IBOutlet weak var openSideMenu: UIBarButtonItem!
    @IBOutlet weak var phenomenaButton: UIButton!
    @IBOutlet weak var constellationsButton: UIButton!
    @IBOutlet weak var clothingButton: UIButton!
    @IBOutlet weak var moonPhases: UIButton!
    
    var stateControlData: StateControlData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("slide_informations", comment: "informations")

        openSideMenu.image = UIImage(named: "slide_menu")
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadInformationsContent()
    }

    func loadInformationsContent(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        var largerSide: CGFloat!
        
        if screenSize.width > screenSize.height{
            largerSide = screenSize.width
        }else{
            largerSide = screenSize.height
        }
        
        let phenomenaImage: UIImage = UIImage(named: "phenomena48")!
        phenomenaButton.setImage(phenomenaImage, for: .normal)
        phenomenaButton.tintColor = .white
        phenomenaButton.setTitle(NSLocalizedString("informations_phenomena", comment: "informations phenomena button"), for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewOne = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewOne.backgroundColor=UIColor.white
        phenomenaButton.addSubview(lineViewOne)
        
        let constellationsImage: UIImage = UIImage(named: "constellation48")!
        constellationsButton.setImage(constellationsImage, for: .normal)
        constellationsButton.tintColor = .white
        constellationsButton.setTitle(NSLocalizedString("informations_constellations", comment: "informations contellations button"), for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewTwo = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewTwo.backgroundColor=UIColor.white
        constellationsButton.addSubview(lineViewTwo)
        
        let clothingImage: UIImage = UIImage(named: "mittens48")!
        clothingButton.setImage(clothingImage, for: .normal)
        clothingButton.tintColor = .white
        clothingButton.setTitle(NSLocalizedString("informations_clothing", comment: "informations clothing button"), for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewThree = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewThree.backgroundColor=UIColor.white
        clothingButton.addSubview(lineViewThree)
        
        let moonImage: UIImage = UIImage(named: "waning_crescent48")!
        moonPhases.setImage(moonImage, for: .normal)
        moonPhases.tintColor = .white
        moonPhases.setTitle(NSLocalizedString("informations_moon", comment: "informations moon button"), for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewFour = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewFour.backgroundColor=UIColor.white
        moonPhases.addSubview(lineViewFour)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPhenomena") {
            let destinationController = segue.destination as! PhenomenaTableViewController
            destinationController.stateControlData = self.stateControlData
        }
        if (segue.identifier == "toConstellations") {
            let destinationController = segue.destination as! ConstellationsTableViewController
            destinationController.stateControlData = self.stateControlData
        }
        if (segue.identifier == "toClothing") {
            let destinationController = segue.destination as! ClothingTableViewController
            destinationController.stateControlData = self.stateControlData
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
