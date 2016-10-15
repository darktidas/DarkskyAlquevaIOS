//
//  InterestPointViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by Tiago David on 12/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class InterestPointViewController: UIViewController {

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
    
    var interestPoint: InterestPoint!
    var imagesViews = [UIImageView]()
    var hScrollWidth: CGFloat!
    var hScrollHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Passed: \(interestPoint.name)")

        loadPointInfo()
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(InterestPointViewController.test))
        self.navigationItem.rightBarButtonItem = share
    }
    
    func test(){
        print("DEU")
    }
    
    func loadPointInfo(){
        //let screenSize: CGRect = UIScreen.main.bounds
        //image proportion
        self.horizontalScroll.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        hScrollWidth = self.horizontalScroll.frame.width
        hScrollHeight = self.horizontalScroll.frame.height
        
        let imagesURL = self.interestPoint.imagesURL
        //if let
        var validImgs = [UIImage]()
        
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
                for i in 0...validImgs.count-1{
                    self.imagesViews.append(UIImageView(frame: CGRect(x: self.hScrollWidth*CGFloat(i)-1, y: 0, width: self.hScrollWidth, height: self.hScrollHeight)))
                    //white line
                    print(imagesURL[i])
                    self.imagesViews[i].clipsToBounds = true
                    self.imagesViews[i].image = validImgs[i]
                    //self.imagesViews[i].contentMode = .scaleAspectFit
                    self.horizontalScroll.addSubview(self.imagesViews[i])
                }
                
                print("total valid images = \(validImgs.count)")
                self.horizontalScroll.contentSize = CGSize(width: self.horizontalScroll.frame.width*CGFloat(validImgs.count), height: self.horizontalScroll.frame.height)
            }
        }

        
        self.pointName.text = interestPoint.name
        self.shortDescription.text = interestPoint.shortDescription
        self.coordinates.text = "Lat: \(interestPoint.latitude), Long: \(interestPoint.longitude)"
        
        loadCategoryInfo()
        
        brightness.text = "Brightness: \(interestPoint.qualityParameters["brightness"]!)"
        temperature.text = "Temperature: \(interestPoint.qualityParameters["temperature"]!)"
        
        longDescription.text = interestPoint.longDescription
       
    }
    
    func loadCategoryInfo(){
        
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
                qual[0]?.text = "Astrophoto"
            }else if(interestPoint.typeMap["landscape"])!{
                qual[0]?.text = "Landscape"
            }else{
                qual[0]?.text = "Observation"
            }
        case 2:
            if(interestPoint.typeMap["astrophoto"])!{
                if(interestPoint.typeMap["landscape"])!{
                    qual[0]?.text = "Astrophoto"
                    qual[1]?.text = "Landscape"
                }else{
                    qual[0]?.text = "Astrophoto"
                    qual[1]?.text = "Observation"
                }
            }else{
                qual[0]?.text = "Landscape"
                qual[1]?.text = "Observation"
            }
        case 3:
            qual[0]?.text = "Astrophoto"
            qual[1]?.text = "Landscape"
            qual[2]?.text = "Observation"
        default:
            for q in qual{
                q?.text = ""
            }
        }
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
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
            
            for i in 0...self.imagesViews.count-1{
            self.imagesViews[i].frame = CGRect(x: largerSide*CGFloat(i)-1, y: 0, width: largerSide, height: self.hScrollHeight)
            }
            self.horizontalScroll.contentSize = CGSize(width: largerSide*CGFloat(self.imagesViews.count), height: self.horizontalScroll.frame.height)
            self.horizontalScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        else {
            print("Portrait")
            for i in 0...self.imagesViews.count-1{
                self.imagesViews[i].frame = CGRect(x: smallerSide*CGFloat(i)-1, y: 0, width: smallerSide, height: self.hScrollHeight)
            }
            self.horizontalScroll.contentSize = CGSize(width: smallerSide*CGFloat(self.imagesViews.count), height: self.horizontalScroll.frame.height)
            self.horizontalScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
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
