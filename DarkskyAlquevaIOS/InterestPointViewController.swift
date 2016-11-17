//
//  InterestPointViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by Tiago David on 12/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit
import SystemConfiguration

class InterestPointViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var horizontalScroll: UIScrollView!
    @IBOutlet weak var pointName: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var markerImage: UIImageView!
    @IBOutlet weak var coordinates: UILabel!
    
    @IBOutlet weak var typeOne: UILabel!
    @IBOutlet weak var typeTwo: UILabel!
    @IBOutlet weak var typeThree: UILabel!
    
    @IBOutlet weak var brightness: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var noImageLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var interestPoint: InterestPoint!
    var imagesViews = [UIImageView]()
    var hScrollWidth: CGFloat!
    var hScrollHeight: CGFloat!
    var scrollPositionX: CGFloat!
    
    var existInternetConnection: Bool!
    
    var loadingView = UIView()
    var container = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = interestPoint.name
        
        if !connectedToNetwork(){
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }

        loadPointInfo()
        
        horizontalScroll.isPagingEnabled = true
        
        self.horizontalScroll.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = true
    }
    
    func showLoading() {
        
        let win:UIWindow = UIApplication.shared.delegate!.window!!
        let screenSize: CGRect = UIScreen.main.bounds
        var smallerSide: CGFloat!
        
        if screenSize.width > screenSize.height{
            smallerSide = screenSize.height
        }else{
            smallerSide = screenSize.width
        }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        self.loadingView = UIView(frame: CGRect(x: screenSize.width/4, y: ((self.horizontalScroll.frame.height/2) + ((self.navigationController?.navigationBar.frame.height)! + statusBarHeight))/2, width: 0, height: 0))
        self.loadingView.tag = 1
        self.loadingView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        win.addSubview(self.loadingView)
        
        //ipad
        if smallerSide! > 414 {
            container = UIView(frame: CGRect(x: 0, y: 0, width: smallerSide/5, height: smallerSide/5))
        }else{
            container = UIView(frame: CGRect(x: 0, y: 0, width: smallerSide/3, height: smallerSide/3))
        }
        container.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        container.layer.cornerRadius = 10.0
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.borderWidth = 0.5
        container.clipsToBounds = true
        container.center = self.loadingView.center
        
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: win.frame.width/5, height: win.frame.width/5)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = self.loadingView.center
        
        
        self.loadingView.addSubview(container)
        self.loadingView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    func hideLoading(){
        UIView.animate(withDuration: 0.0, delay: 0, options: .curveEaseOut, animations: {
            self.container.alpha = 0.0
            self.loadingView.alpha = 0.0
            self.activityIndicator.stopAnimating()
        }, completion: { finished in
            self.activityIndicator.removeFromSuperview()
            self.container.removeFromSuperview()
            self.loadingView.removeFromSuperview()
            let win:UIWindow = UIApplication.shared.delegate!.window!!
            let removeView  = win.viewWithTag(1)
            removeView?.removeFromSuperview()
        })
    }
    
    @IBAction func shareButtonClick(_ sender: AnyObject) {
        
        let title: NSString = self.interestPoint.name as NSString
        let description: NSString = self.interestPoint.longDescription as NSString
        
        let url = NSURL(string: "http://www.darkskyalqueva.com/")
        var shareImg = UIImage()
        if imagesViews[0].image != nil{
            shareImg = imagesViews[0].image!
        }
        
        guard let link = url else {
            print("nothing found")
            return
        }
        
        let share = [title, description, shareImg, link] as [Any]
        let activityViewController = UIActivityViewController(activityItems: share, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.assignToContact, UIActivityType.addToReadingList]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func loadPointInfo(){
        self.showLoading()
        self.horizontalScroll.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        hScrollWidth = self.horizontalScroll.frame.width
        hScrollHeight = self.horizontalScroll.frame.height
        
        let imagesURL = self.interestPoint.imagesURL
        //if let
        var validImgs = [UIImage]()
        
        if connectedToNetwork() {
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    
                    for img in imagesURL{
                        let url: NSURL = NSURL(string: img)!
                        do {
                            let imgData = try NSData(contentsOf: url as URL, options: NSData.ReadingOptions())
                            validImgs.append(UIImage(data: imgData as Data)!)
                        } catch {
                            print(error)
                        }
                    }
                    
                    if validImgs.count > 0{
                        self.hideLoading()
                        
                        for i in 0...validImgs.count-1{
                            self.imagesViews.append(UIImageView(frame: CGRect(x: self.hScrollWidth*CGFloat(i), y: 0, width: self.hScrollWidth, height: self.hScrollHeight)))
                            //white line
                            print(imagesURL[i])
                            self.imagesViews[i].clipsToBounds = true
                            self.imagesViews[i].image = validImgs[i]
                            self.imagesViews[i].contentMode = .scaleAspectFit
                            self.horizontalScroll.addSubview(self.imagesViews[i])
                        }
                        
                        print("total valid images = \(validImgs.count)")
                        self.horizontalScroll.contentSize = CGSize(width: self.horizontalScroll.frame.width*CGFloat(validImgs.count), height: self.horizontalScroll.frame.height)
                    }else{
                        self.hideLoading()
                        self.noImageLabel.text = NSLocalizedString("point_no_images", comment: "no images found")
                    }
                }
            }
        }else{
            self.hideLoading()
            self.noImageLabel.text = NSLocalizedString("point_no_internet", comment: "no internet conection")
        }
        
        self.pointName.text = interestPoint.name
        self.shortDescription.text = interestPoint.shortDescription
        self.coordinates.text = "Lat: \(interestPoint.latitude), Long: \(interestPoint.longitude)"
        
        loadCategoryInfo()
        
        let brightnessLabel = NSLocalizedString("point_brightness", comment: "point brightness label")
        let temperatureLabel = NSLocalizedString("point_temperature", comment: "point temperature label")
        if interestPoint.qualityParameters["brightness"] != nil{
            brightness.text = "\(brightnessLabel): \(interestPoint.qualityParameters["brightness"]!)"
        }else{
            brightness.text = "\(brightnessLabel):  -"
        }
        if interestPoint.qualityParameters["temperature"] != nil{
            temperature.text = "\(temperatureLabel): \(interestPoint.qualityParameters["temperature"]!)"
        }else{
            temperature.text = "\(temperatureLabel):  -"
        }
        
        longDescription.text = interestPoint.longDescription
    }
    
    func loadCategoryInfo(){
        let astrophotoLabel = NSLocalizedString("point_astrophoto", comment: "point astrophoto label")
        let landscapeLabel = NSLocalizedString("point_landscape", comment: "point landscape label")
        let observationLabel = NSLocalizedString("point_observation", comment: "point observation label")
        
        var count = 0
        
        if (interestPoint.typeMap["astrophoto"])! {
            count += 1
        }
        
        if (interestPoint.typeMap["landscape"])! {
            count += 1
        }
        
        if (interestPoint.typeMap["observation"])! {
            count += 1
        }
        
        let qual = [typeOne, typeTwo, typeThree]
        
        switch count {
        case 1:
            if(interestPoint.typeMap["astrophoto"])!{
                qual[0]?.text = astrophotoLabel
            }else if(interestPoint.typeMap["landscape"])!{
                qual[0]?.text = landscapeLabel
            }else{
                qual[0]?.text = observationLabel
            }
        case 2:
            if(interestPoint.typeMap["astrophoto"])!{
                if(interestPoint.typeMap["landscape"])!{
                    qual[0]?.text = astrophotoLabel
                    qual[1]?.text = landscapeLabel
                }else{
                    qual[0]?.text = astrophotoLabel
                    qual[1]?.text = observationLabel
                }
            }else{
                qual[0]?.text = landscapeLabel
                qual[1]?.text = observationLabel
            }
        case 3:
            qual[0]?.text = astrophotoLabel
            qual[1]?.text = landscapeLabel
            qual[2]?.text = observationLabel
        default:
            for q in qual{
                q?.text = ""
            }
        }
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        scrollPositionX = self.horizontalScroll.contentOffset.x
        let screenSize: CGRect = UIScreen.main.bounds
        var largerSide: CGFloat!
        var smallerSide: CGFloat!
        
        if screenSize.width > screenSize.height{
            largerSide = screenSize.width
            smallerSide = screenSize.height
        }else{
            largerSide = screenSize.height
            smallerSide = screenSize.width
        }
        
        if (toInterfaceOrientation.isLandscape) {
            if self.imagesViews.count > 0 {
                for i in 0...self.imagesViews.count-1{
                    self.imagesViews[i].frame = CGRect(x: largerSide*CGFloat(i)-1, y: 0, width: largerSide, height: self.hScrollHeight)
                }
                self.horizontalScroll.contentSize = CGSize(width: largerSide*CGFloat(self.imagesViews.count), height: self.horizontalScroll.frame.height)
                let newPosX = (scrollPositionX*largerSide)/smallerSide
                print(newPosX)
                
                self.horizontalScroll.setContentOffset(CGPoint(x: newPosX, y: 0), animated: true)
            }
        }
        else {
            if self.imagesViews.count > 0 {
                for i in 0...self.imagesViews.count-1{
                    self.imagesViews[i].frame = CGRect(x: smallerSide*CGFloat(i)-1, y: 0, width: smallerSide, height: self.hScrollHeight)
                }
                self.horizontalScroll.contentSize = CGSize(width: smallerSide*CGFloat(self.imagesViews.count), height: self.horizontalScroll.frame.height)
                let newPosX = (scrollPositionX*smallerSide)/largerSide
                self.horizontalScroll.setContentOffset(CGPoint(x: newPosX, y: 0), animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
