//
//  MoonViewController.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 10/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class MoonViewController: UIViewController {

    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var moonImage: UIImageView!
    @IBOutlet weak var moonName: UILabel!
    @IBOutlet weak var dayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadContent()
        loadTodayPhase()
        // Do any additional setup after loading the view.
    }
    
    func loadContent(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        var largerSide: CGFloat!
        
        if screenSize.width > screenSize.height{
            largerSide = screenSize.width
        }else{
            largerSide = screenSize.height
        }
        topText.text = NSLocalizedString("moon_title", comment: "moon title")
        
        let calendarImage: UIImage = UIImage(named: "calendar48")!
        dayButton.setImage(calendarImage, for: .normal)
        dayButton.tintColor = .white
        dayButton.setTitle(NSLocalizedString("moon_button_date", comment: "search button text"), for: .normal)
        dayButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        let lineView = UIView(frame: CGRect(x:0, y:0, width: largerSide, height:1))
        lineView.backgroundColor=UIColor.white
        dayButton.addSubview(lineView)
    }

    func loadTodayPhase(){
        let date = Date()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        print("day = \(day)/\(month)/\(year)")
        
        phaseCalculation(year: year, month: month, day: day)
    }
    
    func phaseCalculation(year: Int, month: Int, day: Int){
        
        let calculation = MoonCalculator()
        let phaseNumber = calculation.moonPhase(year: year, month: month, day: day)
        let phaseName = calculation.phaseName(phase: phaseNumber)
        print(phaseName)
        
        var image: UIImage
        
        switch phaseName {
        case "Waxing crescent":
            image = UIImage(named: "waxing_crescent")!
            moonName.text = NSLocalizedString("moon_waxing_crescent", comment: "moon phase name")
        case "First quarter":
            image = UIImage(named: "first_quarter")!
            moonName.text = NSLocalizedString("moon_first_quarter", comment: "moon phase name")
        case "Waxing gibbous":
            image = UIImage(named: "waxing_gibbous")!
            moonName.text = NSLocalizedString("moon_waxing_gibbous", comment: "moon phase name")
        case "Full":
            image = UIImage(named: "full_moon")!
            moonName.text = NSLocalizedString("moon_full", comment: "moon phase name")
        case "Waning gibbous":
            image = UIImage(named: "waning_gibbous")!
            moonName.text = NSLocalizedString("moon_waning_gibbous", comment: "moon phase name")
        case "Third quarter":
            image = UIImage(named: "third_quarter")!
            moonName.text = NSLocalizedString("moon_third_quarter", comment: "moon phase name")
        case "Waning crescent":
            image = UIImage(named: "waning_crescent")!
            moonName.text = NSLocalizedString("moon_waning_crescent", comment: "moon phase name")
        default:
            image = UIImage(named: "new_moon")!//new
            moonName.text = NSLocalizedString("moon_new", comment: "moon phase name")
        }
        
        moonImage.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseDay(_ sender: AnyObject) {
        
        DatePickerDialog().show(title: NSLocalizedString("moon_date_title", comment: "date picker title"), doneButtonTitle: NSLocalizedString("moon_date_done", comment: "date picker done"), cancelButtonTitle: NSLocalizedString("moon_date_cancel", comment: "date picker cancel"), datePickerMode: .date) {
            (date) -> Void in
            print(date)
            
            if (date != nil){
                let calendar = Calendar.current
                
                let day = calendar.component(.day, from: date!)
                let month = calendar.component(.month, from: date!)
                let year = calendar.component(.year, from: date!)
                self.phaseCalculation(year: year, month: month, day: day)
                
                //bug today on today
                let partOne = NSLocalizedString("moon_title_second_one", comment: "moon description title")
                let partTwo = NSLocalizedString("moon_title_second_two", comment: "moon description title")
                self.topText.text = "\(partOne) \(year)/\(month)/\(day) \(partTwo)"
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
