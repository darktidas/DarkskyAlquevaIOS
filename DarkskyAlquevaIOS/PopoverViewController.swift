//
//  PopoverViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 15/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit


protocol DestinationViewControllerDelegate {
    func popoverOptionsClick(type: String)
}

class PopoverViewController: UIViewController {

    @IBOutlet weak var astrophoto: UIButton!
    @IBOutlet weak var landscape: UIButton!
    @IBOutlet weak var observation: UIButton!
    @IBOutlet weak var normalMap: UIButton!
    @IBOutlet weak var hybridMap: UIButton!
    @IBOutlet weak var satelliteMap: UIButton!
    @IBOutlet weak var terrainMap: UIButton!
    
    var mapViewController: MapViewController!
    var stateControlData: StateControlData!
    
    var delegate: DestinationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: 160, height: 275)
        
        loadButtons()
    }
    
    func loadButtons(){
        
        var astrophotoCheck: UIImage!
        var landscapeCheck: UIImage!
        var observationCheck: UIImage!
        
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
        
        var normalMapRadio: UIImage!
        var hybridMapRadio: UIImage!
        var satelliteMapRadio: UIImage!
        var terrainMapRadio: UIImage!
        
        if (self.stateControlData.mapConfiguration["normal"])! {
            normalMapRadio = UIImage(named: "checked_radio_button")!
        }else{
            normalMapRadio = UIImage(named: "unchecked_radio_button")!
        }
        if (self.stateControlData.mapConfiguration["hybrid"])! {
            hybridMapRadio = UIImage(named: "checked_radio_button")!
        }else{
            hybridMapRadio = UIImage(named: "unchecked_radio_button")!
        }
        if (self.stateControlData.mapConfiguration["satellite"])! {
            satelliteMapRadio = UIImage(named: "checked_radio_button")!
        }else{
            satelliteMapRadio = UIImage(named: "unchecked_radio_button")!
        }
        if (self.stateControlData.mapConfiguration["terrain"])! {
            terrainMapRadio = UIImage(named: "checked_radio_button")!
        }else{
            terrainMapRadio = UIImage(named: "unchecked_radio_button")!
        }
        
        normalMap.imageView?.contentMode = .scaleAspectFit
        normalMap.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        normalMap.setImage(normalMapRadio, for: .normal)
        normalMap.tintColor = .white
        normalMap.setTitle("Normal Map", for: .normal)
        
        hybridMap.imageView?.contentMode = .scaleAspectFit
        hybridMap.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        hybridMap.setImage(hybridMapRadio, for: .normal)
        hybridMap.tintColor = .white
        hybridMap.setTitle("Hybrid Map", for: .normal)
        
        satelliteMap.imageView?.contentMode = .scaleAspectFit
        satelliteMap.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        satelliteMap.setImage(satelliteMapRadio, for: .normal)
        satelliteMap.tintColor = .white
        satelliteMap.setTitle("Satellite Map", for: .normal)
        
        terrainMap.imageView?.contentMode = .scaleAspectFit
        terrainMap.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        terrainMap.setImage(terrainMapRadio, for: .normal)
        terrainMap.tintColor = .white
        terrainMap.setTitle("Terrain Map", for: .normal)
        
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
        filterAsChanged(type: "mapFilter")
        print(self.stateControlData.mapFilterStatus["astrophoto"])
        print(self.stateControlData.mapFilterStatus["landscape"])
        print(self.stateControlData.mapFilterStatus["observation"])
    }
    
    func filterAsChanged(type: String) {
        delegate?.popoverOptionsClick(type: type)
    }
    
    @IBAction func normalMapClick(_ sender: AnyObject) {
        
        self.stateControlData.mapConfiguration["normal"] = true
        self.stateControlData.mapConfiguration["hybrid"] = false
        self.stateControlData.mapConfiguration["satellite"] = false
        self.stateControlData.mapConfiguration["terrain"] = false
        
        normalMap.setImage(UIImage(named: "checked_radio_button"), for: .normal)
        hybridMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        satelliteMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        terrainMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        
        filterAsChanged(type: "mapConfiguration")
        
        print(self.stateControlData.mapConfiguration["normal"])
        print(self.stateControlData.mapConfiguration["hybrid"])
        print(self.stateControlData.mapConfiguration["satellite"])
        print(self.stateControlData.mapConfiguration["terrain"])
    }
    
    @IBAction func hybridMapClick(_ sender: AnyObject) {
        self.stateControlData.mapConfiguration["normal"] = false
        self.stateControlData.mapConfiguration["hybrid"] = true
        self.stateControlData.mapConfiguration["satellite"] = false
        self.stateControlData.mapConfiguration["terrain"] = false
        
        normalMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        hybridMap.setImage(UIImage(named: "checked_radio_button"), for: .normal)
        satelliteMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        terrainMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        
        filterAsChanged(type: "mapConfiguration")
    }
    
    @IBAction func satelliteMapClick(_ sender: AnyObject) {
        self.stateControlData.mapConfiguration["normal"] = false
        self.stateControlData.mapConfiguration["hybrid"] = false
        self.stateControlData.mapConfiguration["satellite"] = true
        self.stateControlData.mapConfiguration["terrain"] = false
        
        normalMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        hybridMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        satelliteMap.setImage(UIImage(named: "checked_radio_button"), for: .normal)
        terrainMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        
        filterAsChanged(type: "mapConfiguration")
    }
    
    @IBAction func terrainMapClick(_ sender: AnyObject) {
        self.stateControlData.mapConfiguration["normal"] = false
        self.stateControlData.mapConfiguration["hybrid"] = false
        self.stateControlData.mapConfiguration["satellite"] = false
        self.stateControlData.mapConfiguration["terrain"] = true
        
        normalMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        hybridMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        satelliteMap.setImage(UIImage(named: "unchecked_radio_button"), for: .normal)
        terrainMap.setImage(UIImage(named: "checked_radio_button"), for: .normal)
        
        filterAsChanged(type: "mapConfiguration")
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
