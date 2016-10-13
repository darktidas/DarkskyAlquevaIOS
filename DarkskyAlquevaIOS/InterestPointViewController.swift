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
    var interestPoint: InterestPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Passed: \(interestPoint.name)")

        loadPointInfo()
    }
    
    func loadPointInfo(){
        
        self.horizontalScroll.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        let hScrollWidth = self.horizontalScroll.frame.width
        let hScrollHeight = self.horizontalScroll.frame.height
        
        let imagesURL = self.interestPoint.imagesURL
        //if let
        var imagesViews = [UIImageView]()
        
        for i in 0...imagesURL.count-1{
            imagesViews.append(UIImageView(frame: CGRect(x: hScrollWidth*CGFloat(i), y: 0, width: hScrollWidth, height: hScrollHeight)))
            print(imagesURL[i])
        }
        imagesViews[0].image = UIImage(named: "logo")
        imagesViews[1].image = UIImage(named: "labsi2")
        
        self.horizontalScroll.addSubview(imagesViews[0])
        self.horizontalScroll.addSubview(imagesViews[1])
        
        self.horizontalScroll.contentSize = CGSize(width: self.horizontalScroll.frame.width*2, height: self.horizontalScroll.frame.height)
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
