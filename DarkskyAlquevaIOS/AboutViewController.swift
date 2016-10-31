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

        // Do any additional setup after loading the view.
    }
    
    func loadLabelLinks(){
        darkskyLink.isUserInteractionEnabled = true // Remember to do this
        let darkskyTap = UITapGestureRecognizer(target: self, action: #selector(AboutViewController.darkskyTapLink))
        darkskyTap.numberOfTapsRequired = 1
        darkskyLink.addGestureRecognizer(darkskyTap)
        darkskyTap.delegate = self // Remember to extend your class with UIGestureRecognizerDelegate
        
        
        iconsLink.isUserInteractionEnabled = true // Remember to do this
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(AboutViewController.iconTapLink))
        iconTap.numberOfTapsRequired = 1
        iconsLink.addGestureRecognizer(iconTap)
        iconTap.delegate = self // Remember to extend your class with UIGestureRecognizerDelegate
    }

    func darkskyTapLink() {
        print("url clicked")
        let url = NSLocalizedString("about_website_link", comment: "website url")
        UIApplication.shared.open(NSURL(string: url) as! URL)
    }
    
    func iconTapLink() {
        print("url clicked")
        let url = "https://icons8.com"
        UIApplication.shared.open(NSURL(string: url) as! URL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
