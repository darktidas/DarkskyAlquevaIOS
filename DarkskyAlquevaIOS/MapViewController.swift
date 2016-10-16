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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let xml = appDelegate.xml!
        
        interestPoints = xml.interestPoints
        let latitude = 38.3120211
        let longitude = -7.418052
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 11.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        loadMarkers(mapView: mapView)
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
    
    func doSomethingWithData() {
        print("passou informaçao")
        updateMarkers()
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
