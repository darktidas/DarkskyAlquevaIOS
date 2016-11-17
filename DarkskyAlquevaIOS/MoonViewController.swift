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
    @IBOutlet weak var dayButton: TopLineButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("informations_moon", comment: "moon")
        
        loadContent()
        loadTodayPhase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = true
    }
    
    func loadContent(){
        
        topText.text = NSLocalizedString("moon_title", comment: "moon title")
        
        let calendarImage: UIImage = UIImage(named: "calendar48")!
        dayButton.setImage(calendarImage, for: .normal)
        dayButton.setTitle(NSLocalizedString("moon_button_date", comment: "search button text"), for: .normal)
    }

    func loadTodayPhase(){
        let date = Date()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
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
            
            if (date != nil){
                
                let calendar = Calendar.current
                
                let day = calendar.component(.day, from: date!)
                let month = calendar.component(.month, from: date!)
                let year = calendar.component(.year, from: date!)
                self.phaseCalculation(year: year, month: month, day: day)
                
                let todayDate = Date()
                
                let order = calendar.compare(date!, to: todayDate, toGranularity: .day)
                
                if order == .orderedDescending{
                    
                    let partOne = NSLocalizedString("moon_title_second_one", comment: "moon description title")
                    let partTwo = NSLocalizedString("moon_title_second_two", comment: "moon description title")
                    self.topText.text = "\(partOne) \(year)/\(month)/\(day) \(partTwo)"
                    
                } else if order == .orderedSame{
                    
                    self.topText.text = NSLocalizedString("moon_title", comment: "moon title")
                    
                } else {
                    
                    let partOne = NSLocalizedString("moon_title_second_one", comment: "moon description title")
                    let partTwo = NSLocalizedString("moon_title_second_three", comment: "moon description title")
                    self.topText.text = "\(partOne) \(year)/\(month)/\(day) \(partTwo)"
                    
                }
            }
        }
    }
}
