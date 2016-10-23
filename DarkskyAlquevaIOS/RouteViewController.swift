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
    @IBOutlet weak var accommodationButton: UIButton!
    @IBOutlet weak var gastronomyButton: UIButton!
    @IBOutlet weak var activitiesButton: UIButton!
    @IBOutlet weak var newsEventsButton: UIButton!
    @IBOutlet weak var routeText: UILabel!
    
    //EN
    let accomodationEN = "Accomodation"
    let gastronomyEN = "Gastronomy"
    let activitiesEN = "Activities"
    let newsEN = "News and  Events"
    
    //PT
    let accomodationPT = "Alojamento"
    let gastronomyPT = "Gastronomia"
    let activitiesPT = "Atividades"
    let newsPT = "Notícias e Eventos"
    
    //ES
    let accomodationES = "Alojamiento"
    let gastronomyES = "Gastronomía"
    let activitiesES = "Actividades"
    let newsES = "Noticias y Eventos"
    
    var stateControlData: StateControlData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openSideMenu.image = UIImage(named: "slide_menu")
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadRouteContent()
    }

    func loadRouteContent(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        var largerSide: CGFloat!
        
        if screenSize.width > screenSize.height{
            largerSide = screenSize.width
        }else{
            largerSide = screenSize.height
        }
        
        let bungalowImage: UIImage = UIImage(named: "bungalow48")!
        accommodationButton.setImage(bungalowImage, for: .normal)
        accommodationButton.tintColor = .white
        accommodationButton.setTitle(NSLocalizedString("route_accomodation", comment: "route accomodation label"), for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewOne = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewOne.backgroundColor=UIColor.white
        accommodationButton.addSubview(lineViewOne)
        
        
        let cutleryImage: UIImage = UIImage(named: "cutlery48")!
        gastronomyButton.setImage(cutleryImage, for: .normal)
        gastronomyButton.tintColor = .white
        gastronomyButton.setTitle(NSLocalizedString("route_gastronomy", comment: "route gastronomy label"), for: .normal)
        //gastronomyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewTwo = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewTwo.backgroundColor=UIColor.white
        gastronomyButton.addSubview(lineViewTwo)
        
        let telescopeImage: UIImage = UIImage(named: "telescope48")!
        activitiesButton.setImage(telescopeImage, for: .normal)
        activitiesButton.tintColor = .white
        activitiesButton.setTitle(NSLocalizedString("route_activities", comment: "route activities label"), for: .normal)
        //activitiesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewThree = UIView(frame: CGRect(x:0, y:60, width:largerSide, height:1))
        lineViewThree.backgroundColor=UIColor.white
        activitiesButton.addSubview(lineViewThree)
        
        let newsImage: UIImage = UIImage(named: "news48")!
        newsEventsButton.setImage(newsImage, for: .normal)
        newsEventsButton.tintColor = .white
        newsEventsButton.setTitle(NSLocalizedString("route_news_events", comment: "route news events label"), for: .normal)
        //newsEventsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewFour = UIView(frame: CGRect(x:0, y:60, width:largerSide, height:1))
        lineViewFour.backgroundColor=UIColor.white
        newsEventsButton.addSubview(lineViewFour)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
