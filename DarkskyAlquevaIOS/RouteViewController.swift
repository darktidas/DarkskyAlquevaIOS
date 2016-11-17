//
//  RouteViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 24/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class RouteViewController: UIViewController {

    @IBOutlet weak var openSideMenu: UIBarButtonItem!
  
    @IBOutlet weak var accommodationButton: SubmenuButtonView!
    
    @IBOutlet weak var gastronomyButton: SubmenuButtonView!
 
    @IBOutlet weak var activitiesButton: SubmenuButtonView!
    
    @IBOutlet weak var newsEventsButton: SubmenuButtonView!
    @IBOutlet weak var routeText: UILabel!
    
    var stateControlData: StateControlData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("slide_route", comment: "route")
        
        openSideMenu.image = UIImage(named: "slide_menu")
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadRouteContent()
    }
    
    func loadRouteContent(){
        
        let bungalowImage: UIImage = UIImage(named: "bungalow48")!
        accommodationButton.setImage(bungalowImage, for: .normal)
        accommodationButton.setTitle(NSLocalizedString("route_accomodation", comment: "route accomodation label"), for: .normal)
        
        let cutleryImage: UIImage = UIImage(named: "cutlery48")!
        gastronomyButton.setImage(cutleryImage, for: .normal)
        gastronomyButton.setTitle(NSLocalizedString("route_gastronomy", comment: "route gastronomy label"), for: .normal)
        
        let telescopeImage: UIImage = UIImage(named: "telescope48")!
        activitiesButton.setImage(telescopeImage, for: .normal)
        activitiesButton.setTitle(NSLocalizedString("route_activities", comment: "route activities label"), for: .normal)
        
        let newsImage: UIImage = UIImage(named: "news48")!
        newsEventsButton.setImage(newsImage, for: .normal)
        newsEventsButton.setTitle(NSLocalizedString("route_news_events", comment: "route news events label"), for: .normal)
        
        routeText.text = stateControlData.xml.route
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func accomodationButtonAction(_ sender: AnyObject) {
        if let url = URL(string: NSLocalizedString("route_accomodation_link", comment: "route accomodation link")) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func gastronomyButtonAction(_ sender: AnyObject) {
        if let url = URL(string: NSLocalizedString("route_gastronomy_link", comment: "route gastronomy link")) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func activitiesButtonAction(_ sender: AnyObject) {
        if let url = URL(string: NSLocalizedString("route_activities_link", comment: "route activities link")) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func newsEventsButtonAction(_ sender: AnyObject) {
        if let url = URL(string: NSLocalizedString("route_news_events_link", comment: "route accomodatinews events link")) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
