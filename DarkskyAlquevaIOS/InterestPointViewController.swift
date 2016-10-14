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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Passed: \(interestPoint.name)")

        loadPointInfo()
        
    }
    
    func loadPointInfo(){
        
        self.pointName.text = interestPoint.name
        self.shortDescription.text = interestPoint.shortDescription
        self.coordinates.text = "Lat: \(interestPoint.latitude), Long: \(interestPoint.longitude)"
        
        loadCategoryInfo()
        
        brightness.text = "Brightness: \(interestPoint.qualityParameters["brightness"]!)"
        temperature.text = "Temperature: \(interestPoint.qualityParameters["temperature"]!)"
        
        longDescription.text = interestPoint.longDescription
        
        self.horizontalScroll.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        let hScrollWidth = self.horizontalScroll.frame.width
        let hScrollHeight = self.horizontalScroll.frame.height
        
        let imagesURL = self.interestPoint.imagesURL
        //if let
        var imagesViews = [UIImageView]()
        
       
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
                    imagesViews.append(UIImageView(frame: CGRect(x: hScrollWidth*CGFloat(i)-1, y: 0, width: hScrollWidth, height: hScrollHeight)))
                    //white linevi
                    print(imagesURL[i])
                    imagesViews[i].clipsToBounds = true
                    imagesViews[i].image = validImgs[i]
                    self.horizontalScroll.addSubview(imagesViews[i])
                }
        
                print("total valid images = \(validImgs.count)")
                self.horizontalScroll.contentSize = CGSize(width: self.horizontalScroll.frame.width*CGFloat(validImgs.count), height: self.horizontalScroll.frame.height)
            }
        }
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
