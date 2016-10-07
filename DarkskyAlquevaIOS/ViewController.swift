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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadHomeContent()
    }
    
    func loadHomeContent(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let xml = appDelegate.xml!
        
        abstract.text = xml.general
        abstract.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

