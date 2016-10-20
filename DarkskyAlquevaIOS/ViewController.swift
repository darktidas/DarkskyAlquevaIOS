//
//  ViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 29/07/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var openSideMenu: UIBarButtonItem!
    @IBOutlet weak var abstract: UILabel!
    
    var stateControlData: StateControlData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.stateControlData = appDelegate.stateControlData
        
        openSideMenu.image = UIImage(named: "slide_menu")
        //openSideMenu.imageInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 30)
        
        
        if self.revealViewController() != nil{
            
            self.revealViewController().rearViewRevealOverdraw = 0
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadHomeContent()
    }
    
    func loadHomeContent(){
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let xml = stateControlData.xml
        
        abstract.text = xml?.general
        abstract.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

