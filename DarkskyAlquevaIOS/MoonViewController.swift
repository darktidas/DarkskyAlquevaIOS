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
        topText.text = "Today is:"
        
        let calendarImage: UIImage = UIImage(named: "calendar48")!
        dayButton.setImage(calendarImage, for: .normal)
        dayButton.tintColor = .white
        dayButton.setTitle("Search Moon Phase", for: .normal)
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
        
        moonName.text = phaseName
        
        var image: UIImage
        
        switch phaseName {
        case "Waxing crescent":
            image = UIImage(named: "waxing_crescent")!
        case "First quarter":
            image = UIImage(named: "first_quarter")!
        case "Waxing gibbous":
            image = UIImage(named: "waxing_gibbous")!
        case "Full":
            image = UIImage(named: "full_moon")!
        case "Waning gibbous":
            image = UIImage(named: "waning_gibbous")!
        case "Third quarter":
            image = UIImage(named: "third_quarter")!
        case "Waning crescent":
            image = UIImage(named: "waning_crescent")!
        default:
            image = UIImage(named: "new_moon")!//new
        }
        
        moonImage.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseDay(_ sender: AnyObject) {
        
        DatePickerDialog().show(title: "Choose a Day", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            print(date)
            
            if (date != nil){
                let calendar = Calendar.current
                
                let day = calendar.component(.day, from: date!)
                let month = calendar.component(.month, from: date!)
                let year = calendar.component(.year, from: date!)
                self.phaseCalculation(year: year, month: month, day: day)
                
                self.topText.text = "On \(year)/\(month)/\(day) the moon will be:"
            }
        }
        /*
        
        let datePicker : UIDatePicker = UIDatePicker()
        let datePickerContainer = UIView()
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        print(screenSize.height)
        print(dayButton.frame.size.height)
        
        let pickerSize : CGSize = datePicker.sizeThatFits(CGSize.zero)
        datePickerContainer.frame = CGRect(x: (screenSize.width-pickerSize.width)/2, y: (screenSize.height-pickerSize.height)/2, width: pickerSize.width, height: 200.0)
        datePickerContainer.backgroundColor = UIColor.white
        
        datePicker.frame = CGRect(x: 0, y: 0.0, width: pickerSize.width, height: 200)
        datePicker.setDate(NSDate() as Date, animated: true)
        datePicker.maximumDate = NSDate() as Date
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.addTarget(self, action: Selector(("dateChangedInDate:")), for: UIControlEvents.valueChanged)
        datePickerContainer.addSubview(datePicker)
        
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        doneButton.addTarget(self, action: Selector(("dismissPicker:")), for: UIControlEvents.touchUpInside)
        doneButton.frame    = CGRect(x: 250.0, y: 5.0, width: 70.0, height: 37.0)
        
        datePickerContainer.addSubview(doneButton)
        
        self.view.addSubview(datePickerContainer)*/
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
