//
//  MapViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 24/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, UIPopoverPresentationControllerDelegate, DestinationViewControllerDelegate{

    @IBOutlet weak var openSideMenu: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var filter: UIBarButtonItem!
    var mapView: GMSMapView!
    var markers = [GMSMarker]()
    
    var interestPoints: [Int: InterestPoint]!
    var interestPointChoosen: InterestPoint!
    var stateControlData: StateControlData!
    
    var legendView: MapLegendView!
    var barButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("slide_map", comment: "map")

        openSideMenu.image = UIImage(named: "slide_menu")
        openSideMenu.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        openSideMenu.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .disabled)
        navigationItem.setLeftBarButton(openSideMenu, animated: false)
        
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    
        checkInternetConnection()
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func filterAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "pop", sender: self)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        openSideMenu.isEnabled = true
    }
    
    override func loadView() {
        
        interestPoints = self.stateControlData.xml.interestPoints
        let latitude = 38.3120211
        let longitude = -7.418052
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 11.0)
        
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.isMyLocationEnabled = true
        
        //compass
        self.mapView.settings.compassButton = true
        //mylocation
        self.mapView.settings.myLocationButton = true
        view = self.mapView        
        
        popoverOptionsClick(type: "mapConfiguration")
        loadMarkers(mapView: mapView)
        
        loadMapLegend()
    }
    
    func loadMapLegend(){
        self.legendView = MapLegendView(frame: CGRect(x: 10, y: 10, width: 155, height: 145))
        
        self.legendView.titleLabel.text =  NSLocalizedString("legend_title", comment: "map legend title")
        
        let markerOneImage = UIImage(named: "marker_1_70")
        self.legendView.markerOneImageView.image = markerOneImage
        self.legendView.markerOneTitle.text = NSLocalizedString("legend_type_one", comment: "legend type one")
        
        self.legendView.markerTwoImageView.image = UIImage(named: "marker_2_70")
        self.legendView.markerTwoTitle.text = NSLocalizedString("legend_type_two", comment: "legend type two")
        
        self.legendView.markerThreeImageView.image = UIImage(named: "marker_3_70")
        self.legendView.markerThreeTitle.text = NSLocalizedString("legend_type_three", comment: "legend type three")
        
        self.view.addSubview(self.legendView)
        self.view.bringSubview(toFront: self.legendView)
    }
    
    
    func updateMarkers(){
        
        for mark in markers{
            mark.map = nil
        }
        
        loadMarkers(mapView: self.mapView)
    }
    
    func loadMarkers(mapView: GMSMapView){
        
        for i in 0...interestPoints.count{
            if(interestPoints[i] != nil){
                if(self.stateControlData.mapFilterStatus["astrophoto"]! && (interestPoints[i]?.typeMap["astrophoto"])!){
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: (interestPoints[i]?.latitude)!, longitude: (interestPoints[i]?.longitude)!)
                    marker.title = interestPoints[i]?.name
                    marker.snippet = interestPoints[i]?.shortDescription
                    var count = 0
                    for type in (interestPoints[i]?.typeMap)!{
                        if(type.value){
                            count += 1
                        }
                    }
                    if(count == 1){
                        marker.icon = GMSMarker.markerImage(with: UIColor.yellow)
                    } else if(count == 2){
                        marker.icon = GMSMarker.markerImage(with: UIColor.orange)
                    }
                    marker.map = mapView
                    markers.append(marker)
                } else if(self.stateControlData.mapFilterStatus["landscape"]! && (interestPoints[i]?.typeMap["landscape"])!){
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: (interestPoints[i]?.latitude)!, longitude: (interestPoints[i]?.longitude)!)
                    marker.title = interestPoints[i]?.name
                    marker.snippet = interestPoints[i]?.shortDescription
                    var count = 0
                    for type in (interestPoints[i]?.typeMap)!{
                        if(type.value){
                            count += 1
                        }
                    }
                    if(count == 1){
                        marker.icon = GMSMarker.markerImage(with: UIColor.yellow)
                    } else if(count == 2){
                        marker.icon = GMSMarker.markerImage(with: UIColor.orange)
                    }
                    marker.map = mapView
                    markers.append(marker)
                } else if(self.stateControlData.mapFilterStatus["observation"]! && (interestPoints[i]?.typeMap["observation"])!){
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: (interestPoints[i]?.latitude)!, longitude: (interestPoints[i]?.longitude)!)
                    marker.title = interestPoints[i]?.name
                    marker.snippet = interestPoints[i]?.shortDescription
                    var count = 0
                    for type in (interestPoints[i]?.typeMap)!{
                        if(type.value){
                            count += 1
                        }
                    }
                    if(count == 1){
                        marker.icon = GMSMarker.markerImage(with: UIColor.yellow)
                    } else if(count == 2){
                        marker.icon = GMSMarker.markerImage(with: UIColor.orange)
                    }
                    marker.map = mapView
                    markers.append(marker)
                }else{
                    
                }
            }
        }
        mapView.delegate = self
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        for i in 0...interestPoints.count{
            if(interestPoints[i] != nil){
                if(marker.title == interestPoints[i]?.name){
                    interestPointChoosen = interestPoints[i]
                }
            }
        }
        
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue") {
            let svc = segue.destination as! InterestPointViewController
            svc.interestPoint = interestPointChoosen
            svc.existInternetConnection = stateControlData.internetConnection
        }
        if (segue.identifier == "toPopover") {
            let svc = segue.destination
            if let pop = svc.popoverPresentationController{
                pop.delegate = self
                openSideMenu.isEnabled = false
            }
            let inst = segue.destination as! PopoverViewController
            inst.stateControlData = self.stateControlData
            if let destinationViewController = segue.destination as? PopoverViewController {
                destinationViewController.delegate = self
                
            }
        }
    }
    
    func popoverOptionsClick(type: String) {
        if type == "mapFilter" {
            updateMarkers()
        }
        if type == "mapConfiguration"{
            
            if self.stateControlData.mapConfiguration["normal"]! {
                self.mapView.mapType = kGMSTypeNormal
            }else if self.stateControlData.mapConfiguration["hybrid"]! {
                self.mapView.mapType = kGMSTypeHybrid
            }else if self.stateControlData.mapConfiguration["satellite"]! {
                self.mapView.mapType = kGMSTypeSatellite
            }else{
                self.mapView.mapType = kGMSTypeTerrain
            }
        }
    }
    
    func checkInternetConnection(){
        
        if !self.stateControlData.internetConnection && !self.stateControlData.firstTime {
            
            alert(message: NSLocalizedString("map_alert_no_internet_message", comment: "no internet message")  , title: NSLocalizedString("map_alert_no_internet_title", comment: "no internet title"))
        }
    }
}
