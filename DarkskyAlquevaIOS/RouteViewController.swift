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
    
    let screenSize: CGRect = UIScreen.main.bounds
    var largerSide: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if screenSize.width > screenSize.height{
            largerSide = screenSize.width
        }else{
            largerSide = screenSize.height
        }
        
        let bungalowImage: UIImage = UIImage(named: "bungalow48")!
        accommodationButton.setImage(bungalowImage, for: .normal)
        accommodationButton.tintColor = .white
        accommodationButton.setTitle("Accomodation", for: .normal)
        //accommodationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewOne = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewOne.backgroundColor=UIColor.white
        accommodationButton.addSubview(lineViewOne)
        
        
        let cutleryImage: UIImage = UIImage(named: "cutlery48")!
        gastronomyButton.setImage(cutleryImage, for: .normal)
        gastronomyButton.tintColor = .white
        gastronomyButton.setTitle("Gastronomy", for: .normal)
        //gastronomyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewTwo = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewTwo.backgroundColor=UIColor.white
        gastronomyButton.addSubview(lineViewTwo)
        
        let telescopeImage: UIImage = UIImage(named: "telescope48")!
        activitiesButton.setImage(telescopeImage, for: .normal)
        activitiesButton.tintColor = .white
        activitiesButton.setTitle("Activities", for: .normal)
        //activitiesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewThree = UIView(frame: CGRect(x:0, y:60, width:largerSide, height:1))
        lineViewThree.backgroundColor=UIColor.white
        activitiesButton.addSubview(lineViewThree)
        
        let newsImage: UIImage = UIImage(named: "news48")!
        newsEventsButton.setImage(newsImage, for: .normal)
        newsEventsButton.tintColor = .white
        newsEventsButton.setTitle("News and Events", for: .normal)
        //newsEventsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let lineViewFour = UIView(frame: CGRect(x:0, y:60, width:largerSide, height:1))
        lineViewFour.backgroundColor=UIColor.white
        newsEventsButton.addSubview(lineViewFour)
        
        routeText.text = "Sweet Potato"
        // Do any additional setup after loading the view.
        
        print("accomodationbutton = \(accommodationButton.frame.size.height)")
        print("activitiesbutton = \(activitiesButton.frame.size.height)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accomodationButtonAction(_ sender: AnyObject) {
        if let url = URL(string: "http://www.darkskyalqueva.com/en/alojamento-en/") {
            UIApplication.shared.open(url, options: [:])
        }
        print(screenSize.width)
        print(screenSize.height)
    }
    
    @IBAction func gastronomyButtonAction(_ sender: AnyObject) {
        if let url = URL(string: "http://www.darkskyalqueva.com/en/atividades-en/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func activitiesButtonAction(_ sender: AnyObject) {
        if let url = URL(string: "http://www.darkskyalqueva.com/en/gastronomia-en/") {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func newsEventsButtonAction(_ sender: AnyObject) {
        if let url = URL(string: "http://www.darkskyalqueva.com/en/noticias-en/") {
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
