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
    
    //EN
    let phenomenaEN = "Phenomena"
    let constellationsEN = "Constellations"
    let clothingEN = "Clothing"
    let moonPhasesEN = "Moon Phases"
    
    //PT
    let phenomenaPT = "Fenómenos"
    let constellationsPT = "Constelações"
    let clothingPT = "Vestuário"
    let moonPhasesPT = "Fases da Lua"
    
    //ES
    let phenomenaES = "Fenómenos"
    let constellationsES = "Constelaciónes"
    let clothingES = "Ropa"
    let moonPhasesES = "Fases de la Luna"
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        phenomenaButton.setTitle(phenomenaEN, for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewOne = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewOne.backgroundColor=UIColor.white
        phenomenaButton.addSubview(lineViewOne)
        
        let constellationsImage: UIImage = UIImage(named: "constellation48")!
        constellationsButton.setImage(constellationsImage, for: .normal)
        constellationsButton.tintColor = .white
        constellationsButton.setTitle(constellationsEN, for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewTwo = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewTwo.backgroundColor=UIColor.white
        constellationsButton.addSubview(lineViewTwo)
        
        let clothingImage: UIImage = UIImage(named: "mittens48")!
        clothingButton.setImage(clothingImage, for: .normal)
        clothingButton.tintColor = .white
        clothingButton.setTitle(clothingEN, for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewThree = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewThree.backgroundColor=UIColor.white
        clothingButton.addSubview(lineViewThree)
        
        let moonImage: UIImage = UIImage(named: "waning_crescent48")!
        moonPhases.setImage(moonImage, for: .normal)
        moonPhases.tintColor = .white
        moonPhases.setTitle(moonPhasesEN, for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewFour = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewFour.backgroundColor=UIColor.white
        moonPhases.addSubview(lineViewFour)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
