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
                    imagesViews.append(UIImageView(frame: CGRect(x: hScrollWidth*CGFloat(i), y: 0, width: hScrollWidth, height: hScrollHeight)))
                    print(imagesURL[i])
                    imagesViews[i].image = validImgs[i]
                    self.horizontalScroll.addSubview(imagesViews[i])
                }
        
                print("total valid images = \(validImgs.count)")
                self.horizontalScroll.contentSize = CGSize(width: self.horizontalScroll.frame.width*CGFloat(validImgs.count), height: self.horizontalScroll.frame.height)
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
