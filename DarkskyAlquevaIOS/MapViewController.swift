//
//  MapViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 24/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, UIPopoverPresentationControllerDelegate{

    @IBOutlet weak var openSideMenu: UIBarButtonItem!
    
    var interestPoints: [Int: InterestPoint]!
    var interestPointChoosen: InterestPoint!
    
    var filter: UIBarButtonItem!
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil{
            
            openSideMenu.target = self.revealViewController()
            openSideMenu.action = #selector(SWRevealViewController.revealToggle(_:)) //selector
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        /*
        self.filter = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(MapViewController.loadFilter))
        self.navigationItem.rightBarButtonItem = filter*/
        
    }
    
    @IBAction func filterAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "pop", sender: self)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    /*
    func loadFilter(){
        let playerInformationViewController = (self.storyboard?.instantiateViewController(withIdentifier: "popover"))! as UIViewController
        playerInformationViewController.modalPresentationStyle = .popover
        playerInformationViewController.preferredContentSize = CGSize(width: 300, height: 300)
        
        
        
        let popoverPresentationViewController = playerInformationViewController.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = .any
        popoverPresentationViewController?.delegate = self
        popoverPresentationController?.barButtonItem = self.filter
        present(playerInformationViewController, animated: true, completion: nil)
        
        //popoverPresentationViewController?.barButtonItem = sender as UIBarButtonItem
    }*/

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
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        loadMarkers(mapView: mapView)
    }
    
    func loadMarkers(mapView: GMSMapView){
        for i in 0...interestPoints.count{
            if(interestPoints[i] != nil){
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
        if (segue.identifier == "pop") {
            let svc = segue.destination
            if let pop = svc.popoverPresentationController{
                pop.delegate = self
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
