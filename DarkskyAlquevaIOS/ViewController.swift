//
//  ViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 29/07/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit
import Foundation

extension String {
    func sliceFrom(start: String, to: String) -> String? {
        return (range(of: start)?.upperBound).flatMap { sInd in
            (range(of: to, range: sInd..<endIndex)?.lowerBound).map { eInd in
                substring(with: sInd..<eInd)
            }
        }
    }
}

class ViewController: UIViewController{
    
    @IBOutlet weak var openSideMenu: UIBarButtonItem!
    @IBOutlet weak var abstract: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var stateControlData: StateControlData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("slide_home", comment: "home")      
        
        
        self.stateControlData = appDelegate.stateControlData
        
        checkLanguageChange()
        
        openSideMenu.image = UIImage(named: "slide_menu")
        
        
        if self.revealViewController() != nil{
            
            self.revealViewController().rearViewRevealOverdraw = 0
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadHomeContent()
        
        checkInternetConnection()
    }
    
    func checkLanguageChange() {
        if stateControlData.xml != nil {
            
            /*for i in 1...NSLocale.preferredLanguages.count{
                let prefLanguage = NSLocale.preferredLanguages[i] as String?
                
                if prefLanguage?.range(of: stateControlData.xml.headerInfo.language) == nil{
                    
                }
            }*/
            let systemLanguage = NSLocale.preferredLanguages[0] as String?
            
            if appDelegate.getAppLanguage() != stateControlData.xml.headerInfo.language && !self.stateControlData.internetConnection{
                alert(message: NSLocalizedString("home_alert_new_language" , comment: "no internet title") , title: NSLocalizedString("home_alert_no_internet_title", comment: "no internet title"))
            }

            /*
            if systemLanguage?.range(of: stateControlData.xml.headerInfo.language) == nil && !self.stateControlData.internetConnection{
                 alert(message: NSLocalizedString("home_alert_new_language" , comment: "no internet title") , title: NSLocalizedString("home_alert_no_internet_title", comment: "no internet title"))
            }*/
        }
    }
    
    func checkInternetConnection(){
        
        print("internet = \(self.stateControlData.internetConnection)")
        print("first time = \(self.stateControlData.firstTime)")
        
        if !self.stateControlData.internetConnection && self.stateControlData.firstTime {
        
            alert(message: NSLocalizedString("home_alert_no_internet_message", comment: "no internet message")  , title: NSLocalizedString("home_alert_no_internet_title", comment: "no internet title"))
            
            print("First Case")
        }
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loadHomeContent(){
        
        if self.stateControlData.xml == nil{
           
            if let url = URL(string: NSLocalizedString("dropbox_xml_link", comment: "dropbox link xml")) {
                do {
                    let contents = try String(contentsOf: url)
                    print(contents)
                    let generalString = contents.sliceFrom(start: "input-type=\"textarea\">", to: "</general>")
                    if generalString != nil{
                        abstract.text = generalString!
                        abstract.sizeToFit()
                    }
                } catch {
                    print("Couldn't load data!")
                }
            } else {
                print("Url not working!")
            }
            
        } else {
            abstract.text = self.stateControlData.xml.general
            abstract.sizeToFit()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

