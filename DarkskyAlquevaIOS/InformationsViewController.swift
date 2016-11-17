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
    
    @IBOutlet weak var phenomenaButton: SubmenuButtonView!
    
    @IBOutlet weak var constellationsButton: SubmenuButtonView!
   
    @IBOutlet weak var clothingButton: SubmenuButtonView!

    @IBOutlet weak var moonPhasesButton: SubmenuButtonView!
    
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
        
        let phenomenaImage: UIImage = UIImage(named: "phenomena48")!
        phenomenaButton.setImage(phenomenaImage, for: .normal)
        phenomenaButton.setTitle(NSLocalizedString("informations_phenomena", comment: "informations phenomena button"), for: .normal)
        
        let constellationsImage: UIImage = UIImage(named: "constellation48")!
        constellationsButton.setImage(constellationsImage, for: .normal)
        constellationsButton.setTitle(NSLocalizedString("informations_constellations", comment: "informations contellations button"), for: .normal)
        
        let clothingImage: UIImage = UIImage(named: "mittens48")!
        clothingButton.setImage(clothingImage, for: .normal)
        clothingButton.setTitle(NSLocalizedString("informations_clothing", comment: "informations clothing button"), for: .normal)
        
        let moonImage: UIImage = UIImage(named: "waning_crescent48")!
        moonPhasesButton.setImage(moonImage, for: .normal)
        moonPhasesButton.setTitle(NSLocalizedString("informations_moon", comment: "informations moon button"), for: .normal)
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
    }
}
