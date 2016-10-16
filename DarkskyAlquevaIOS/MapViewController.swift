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
    
    var legendView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openSideMenu.image = UIImage(named: "slide_menu")
        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func filterAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "pop", sender: self)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.legendView = UIView(frame: CGRect(x: 10, y: 10, width: 150, height: 145))
        self.legendView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        let title = UILabel(frame: CGRect(x: 5, y: 5, width: 140, height: 20))
        title.font = title.font.withSize(14)
        title.text = "Interest Points Types"
        title.textAlignment = .center
        self.legendView.addSubview(title)
        
        let markerOneView = UIImageView(frame: CGRect(x: 10, y: 30, width: 40, height: 40))
        let markerOne = UIImage(named: "marker_1_70")
        markerOneView.image = markerOne
        markerOneView.contentMode = .scaleAspectFit
        let markerOneText = UILabel(frame: CGRect(x: 55, y: 40, width: 120, height: 20))
        markerOneText.font = markerOneText.font.withSize(13)
        markerOneText.text = "One Type"
        self.legendView.addSubview(markerOneView)
        self.legendView.addSubview(markerOneText)
        
        let markerTwoView = UIImageView(frame: CGRect(x: 10, y: 65, width: 40, height: 40))
        let markerTwo = UIImage(named: "marker_2_70")
        markerTwoView.image = markerTwo
        markerTwoView.contentMode = .scaleAspectFit
        let markerTwoText = UILabel(frame: CGRect(x: 55, y: 75, width: 120, height: 20))
        markerTwoText.font = markerTwoText.font.withSize(13)
        markerTwoText.text = "Two Types"
        self.legendView.addSubview(markerTwoView)
        self.legendView.addSubview(markerTwoText)
        
        let markerThreeView = UIImageView(frame: CGRect(x: 10, y: 100, width: 40, height: 40))
        let markerThree = UIImage(named: "marker_3_70")
        markerThreeView.image = markerThree
        markerThreeView.contentMode = .scaleAspectFit
        let markerThreeText = UILabel(frame: CGRect(x: 55, y: 110, width: 120, height: 20))
        markerThreeText.font = markerThreeText.font.withSize(13)
        markerThreeText.text = "Three Types"
        self.legendView.addSubview(markerThreeView)
        self.legendView.addSubview(markerThreeText)
        
        self.view.addSubview(self.legendView)
        self.view.bringSubview(toFront: self.legendView)
    }
    
    
    func updateMarkers(){
        print("updated")
        print(markers.count)
        
        for mark in markers{
            mark.map = nil
        }
        //remove nil markers
        
        loadMarkers(mapView: self.mapView)
    }
    
    func loadMarkers(mapView: GMSMapView){
        
        for i in 0...interestPoints.count{
            if(interestPoints[i] != nil){
                if(self.stateControlData.mapFilterStatus["astrophoto"]! && (interestPoints[i]?.typeMap["astrophoto"])!){
                    var marker = GMSMarker()
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
        print(marker.title)
        for i in 0...interestPoints.count{
            if(interestPoints[i] != nil){
                if(marker.title == interestPoints[i]?.name){
                    interestPointChoosen = interestPoints[i]
                }
            }
        }
        
        performSegue(withIdentifier: "segue", sender: nil)
        /*
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         
         let interestPointInfoView = storyBoard.instantiateViewController(withIdentifier: "InterestPointViewController") as! InterestPointViewController
         self.navigationController?.pushViewController(interestPointInfoView, animated: true)*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue") {
            let svc = segue.destination as! InterestPointViewController
            svc.interestPoint = interestPointChoosen
        }
        if (segue.identifier == "toPopover") {
            let svc = segue.destination
            if let pop = svc.popoverPresentationController{
                pop.delegate = self
            }
            let inst = segue.destination as! PopoverViewController
            inst.stateControlData = self.stateControlData
            //inst.mapViewController = self
            
            //for delegate
            if let destinationViewController = segue.destination as? PopoverViewController {
                destinationViewController.delegate = self
            }
        }
    }
    
    func popoverOptionsClick(type: String) {
        print("passou informaçao")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
