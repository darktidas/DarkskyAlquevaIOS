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

    @IBOutlet weak var astrophoto: PopoverButtonView!
    @IBOutlet weak var landscape: PopoverButtonView!
    @IBOutlet weak var observation: PopoverButtonView!
    @IBOutlet weak var normalMap: PopoverButtonView!
    @IBOutlet weak var hybridMap: PopoverButtonView!
    @IBOutlet weak var satelliteMap: PopoverButtonView!
    @IBOutlet weak var terrainMap: PopoverButtonView!
    
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
        
        astrophoto.setImage(astrophotoCheck, for: .normal)
        astrophoto.setTitle(NSLocalizedString("popover_astrophoto", comment: "popover astropoto type"), for: .normal)
        
        landscape.setImage(landscapeCheck, for: .normal)
        landscape.setTitle(NSLocalizedString("popover_landscape", comment: "popover landscape type"), for: .normal)
        
        observation.setImage(observationCheck, for: .normal)
        observation.setTitle(NSLocalizedString("popover_observation", comment: "popover observation type"), for: .normal)
        
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
        
        normalMap.setImage(normalMapRadio, for: .normal)
        normalMap.setTitle(NSLocalizedString("popover_normal", comment: "popover normal type"), for: .normal)
        
        hybridMap.setImage(hybridMapRadio, for: .normal)
        hybridMap.setTitle(NSLocalizedString("popover_hybrid", comment: "popover hybrid type"), for: .normal)
        
        satelliteMap.setImage(satelliteMapRadio, for: .normal)
        satelliteMap.setTitle(NSLocalizedString("popover_satellite", comment: "popover satellite type"), for: .normal)
        
        terrainMap.setImage(terrainMapRadio, for: .normal)
        terrainMap.setTitle(NSLocalizedString("popover_terrain", comment: "popover terrain type"), for: .normal)
        
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
    }
    
}
