//
//  AboutViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 24/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UIGestureRecognizerDelegate{

    @IBOutlet weak var openSideMenu: UIBarButtonItem!
    @IBOutlet weak var darkskyLink: UILabel!
    @IBOutlet weak var iconsLink: UILabel!
    
    @IBOutlet weak var developerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("slide_about", comment: "about")

        openSideMenu.image = UIImage(named: "slide_menu")
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadLabelLinks()
    }
    
    func loadLabelLinks(){
        darkskyLink.isUserInteractionEnabled = true
        let darkskyTap = UITapGestureRecognizer(target: self, action: #selector(AboutViewController.darkskyTapLink))
        darkskyTap.numberOfTapsRequired = 1
        darkskyLink.addGestureRecognizer(darkskyTap)
        darkskyTap.delegate = self
        
        
        iconsLink.isUserInteractionEnabled = true
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(AboutViewController.iconTapLink))
        iconTap.numberOfTapsRequired = 1
        iconsLink.addGestureRecognizer(iconTap)
        iconTap.delegate = self
    }

    func darkskyTapLink() {
        print("url clicked")
        let url = NSLocalizedString("about_website_link", comment: "website url")
        //UIApplication.shared.open(NSURL(string: url) as! URL)
        UIApplication.shared.openURL(URL(string: url)!)
    }
    
    func iconTapLink() {
        print("url clicked")
        let url = "https://icons8.com"
        UIApplication.shared.openURL(URL(string: url)!)
        //UIApplication.shared.open(NSURL(string: url) as! URL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
