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
    
    override func viewDidAppear(_ animated: Bool) {
        //loadHomeContent()
    }
    
    func loadHomeContent(){
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
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

