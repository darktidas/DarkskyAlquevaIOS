//
//  PopoverViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 15/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var astrophoto: UIButton!
    @IBOutlet weak var landscape: UIButton!
    @IBOutlet weak var observation: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var astrophotoCheck: UIImage!
    var landscapeCheck: UIImage!
    var observationCheck: UIImage!
    
    var mapViewController: MapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: 200, height: 200)
        
        loadButtons()
        
        print(appDelegate.mapFilterStatus["astrophoto"])
        print(appDelegate.mapFilterStatus["landscape"])
        print(appDelegate.mapFilterStatus["observation"])
    }
    
    func loadButtons(){
        
        if (appDelegate.mapFilterStatus["astrophoto"])! {
            astrophotoCheck = UIImage(named: "checked_checkbox48")!
        }else{
            astrophotoCheck = UIImage(named: "unchecked_checkbox48")!
        }
        if (appDelegate.mapFilterStatus["landscape"])! {
            landscapeCheck = UIImage(named: "checked_checkbox48")!
        }else{
            landscapeCheck = UIImage(named: "unchecked_checkbox48")!
        }
        if (appDelegate.mapFilterStatus["observation"])! {
            observationCheck = UIImage(named: "checked_checkbox48")!
        }else{
            observationCheck = UIImage(named: "unchecked_checkbox48")!
        }
        
        astrophoto.imageView?.contentMode = .scaleAspectFit
        astrophoto.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        astrophoto.setImage(astrophotoCheck, for: .normal)
        astrophoto.tintColor = .white
        astrophoto.setTitle("Astrophoto", for: .normal)
        
        landscape.imageView?.contentMode = .scaleAspectFit
        landscape.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        landscape.setImage(landscapeCheck, for: .normal)
        landscape.tintColor = .white
        landscape.setTitle("Landscape", for: .normal)
        
        observation.imageView?.contentMode = .scaleAspectFit
        observation.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        observation.setImage(observationCheck, for: .normal)
        observation.tintColor = .white
        observation.setTitle("Observation", for: .normal)
    }
    
    @IBAction func astrophotoClick(_ sender: AnyObject) {
        if (appDelegate.mapFilterStatus["astrophoto"])! {
            appDelegate.mapFilterStatus["astrophoto"] = false
            astrophoto.setImage(UIImage(named: "unchecked_checkbox48"), for: .normal)
        }else{
            appDelegate.mapFilterStatus["astrophoto"] = true
            astrophoto.setImage(UIImage(named: "checked_checkbox48"), for: .normal)
        }
        self.mapViewController.updateMarkers()
        print(appDelegate.mapFilterStatus["astrophoto"])
        print(appDelegate.mapFilterStatus["landscape"])
        print(appDelegate.mapFilterStatus["observation"])
    }
    
    @IBAction func landscapeClick(_ sender: AnyObject) {
        if (appDelegate.mapFilterStatus["landscape"])! {
            appDelegate.mapFilterStatus["landscape"] = false
            landscape.setImage(UIImage(named: "unchecked_checkbox48"), for: .normal)
        }else{
            appDelegate.mapFilterStatus["landscape"] = true
            landscape.setImage(UIImage(named: "checked_checkbox48"), for: .normal)
        }
        
        self.mapViewController.updateMarkers()
        print(appDelegate.mapFilterStatus["astrophoto"])
        print(appDelegate.mapFilterStatus["landscape"])
        print(appDelegate.mapFilterStatus["observation"])
    }
    
    @IBAction func observationClick(_ sender: AnyObject) {
        if (appDelegate.mapFilterStatus["observation"])! {
            appDelegate.mapFilterStatus["observation"] = false
            observation.setImage(UIImage(named: "unchecked_checkbox48"), for: .normal)
        }else{
            appDelegate.mapFilterStatus["observation"] = true
            observation.setImage(UIImage(named: "checked_checkbox48"), for: .normal)
        }
        self.mapViewController.updateMarkers()
        print(appDelegate.mapFilterStatus["astrophoto"])
        print(appDelegate.mapFilterStatus["landscape"])
        print(appDelegate.mapFilterStatus["observation"])
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
