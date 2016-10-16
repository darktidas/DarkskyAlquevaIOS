//
//  PopoverViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 15/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit


protocol DestinationViewControllerDelegate {
    func doSomethingWithData()
}

class PopoverViewController: UIViewController {

    @IBOutlet weak var astrophoto: UIButton!
    @IBOutlet weak var landscape: UIButton!
    @IBOutlet weak var observation: UIButton!
    @IBOutlet weak var normalMap: UIButton!
    @IBOutlet weak var hybridMap: UIButton!
    @IBOutlet weak var satelliteMap: UIButton!
    @IBOutlet weak var terrainMap: UIButton!
    
    var astrophotoCheck: UIImage!
    var landscapeCheck: UIImage!
    var observationCheck: UIImage!
    
    var mapViewController: MapViewController!
    var stateControlData: StateControlData!
    
    var delegate: DestinationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: 200, height: 200)
        
        loadButtons()
        
        print(self.stateControlData.mapFilterStatus["astrophoto"])
        print(self.stateControlData.mapFilterStatus["landscape"])
        print(self.stateControlData.mapFilterStatus["observation"])
    }
    
    func loadButtons(){
        
        if (self.stateControlData.mapFilterStatus["astrophoto"])! {
            astrophotoCheck = UIImage(named: "checked_checkbox48")!
        }else{
            astrophotoCheck = UIImage(named: "unchecked_checkbox48")!
        }
        if (self.stateControlData.mapFilterStatus["landscape"])! {
            landscapeCheck = UIImage(named: "checked_checkbox48")!
        }else{
            landscapeCheck = UIImage(named: "unchecked_checkbox48")!
        }
        if (self.stateControlData.mapFilterStatus["observation"])! {
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
        
        loadRadioButtons()
    }
    
    func loadRadioButtons(){
        
        
    }
    
    @IBAction func astrophotoClick(_ sender: AnyObject) {
        filterCheck(button: astrophoto, name: "astrophoto")
    }
    
    @IBAction func landscapeClick(_ sender: AnyObject) {
        filterCheck(button: landscape, name: "landscape")
    }
    
    @IBAction func observationClick(_ sender: AnyObject) {
        filterCheck(button: observation, name: "observation")
    }
    
    func filterCheck(button: UIButton, name: String) {
        if (self.stateControlData.mapFilterStatus[name])! {
            self.stateControlData.mapFilterStatus[name] = false
            button.setImage(UIImage(named: "unchecked_checkbox48"), for: .normal)
        }else{
            self.stateControlData.mapFilterStatus[name] = true
            button.setImage(UIImage(named: "checked_checkbox48"), for: .normal)
        }
        filterAsChanged()
        print(self.stateControlData.mapFilterStatus["astrophoto"])
        print(self.stateControlData.mapFilterStatus["landscape"])
        print(self.stateControlData.mapFilterStatus["observation"])
    }
    
    func filterAsChanged() {
        //let data = "passou uma batata"
        delegate?.doSomethingWithData()
    }
    
    @IBAction func normalMapClick(_ sender: AnyObject) {
    }
    
    @IBAction func hybridMapClick(_ sender: AnyObject) {
    }
    
    @IBAction func satelliteMapClick(_ sender: AnyObject) {
    }
    
    @IBAction func terrainMapClick(_ sender: AnyObject) {
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
