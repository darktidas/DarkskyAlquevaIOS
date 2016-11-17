//
//  MoonCalculator.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 10/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//
// Code from: http://raingod.com/raingod/resources/Programming/Java/Software/Moon/javafiles/MoonCalculation.java

/*
 File:      MoonCalculation.java
 Author:    Angus McIntyre <angus@pobox.com>
 Date:      31.05.96
 Updated:   01.06.96
 
 Java class to calculate the phase of the moon, given a date. The
 'moonPhase' method is a Java port of some public domain C source which
 was apparently originally part of the Decus C distribution (whatever
 that was). Details of the algorithm are given below.
 
 To use this in a program, create an object of class 'MoonCalculation'.
 
 I'm not convinced that the algorithm is entirely accurate, but I don't
 know enough to confirm whether it is or not.
 
 HISTORY
 -------
 
 31.05.96    SLAM    Converted from C
 01.06.96    SLAM    Added 'phaseName' to return the name of a phase.
 Fixed leap year test in 'daysInMonth'.
 
 LEGAL
 -----
 
 This software is free. It can be used and modified in any way you
 choose. The author assumes no liability for any loss or damage you
 may incur through use of or inability to use this software. This
 disclaimer must appear on any modified or unmodified version of
 the software in which the name of the author also appears.
 
 */

import Foundation

class MoonCalculator {
    
    let dayYear = [ -1, -1, 30, 58, 89, 119,
        150, 180, 211, 241, 272,
        303, 333 ]
    
    let moonPhaseName = [
        "New",
        "Waxing crescent",
        "First quarter",
        "Waxing gibbous",
        "Full",
        "Waning gibbous",
        "Third quarter",
        "Waning crescent"]
    
    func moonPhase(year: Int, month: Int, day: Int) -> Int
    {
        var month = month
        var phase: Int         // Moon phase
        var cent: Int          // Century number (1979 = 20)
        var epact: Int         // Age of the moon on Jan. 1
        var diy: Int           // Day in the year
        var golden: Int        // Moon's golden number
    
        if (month < 0 || month > 12){
            month = 0     // Just in case
        }
        
        diy = day + dayYear[month];                // Day in the year
        if ((month > 2) && isLeapYearP(year: year)){
            diy += 1  // Leapyear fixup
        }
        cent = (year / 100) + 1                    // Century number
        golden = (year % 19) + 1                   // Golden number
        epact = ((11 * golden) + 20                 // Golden number
            + (((8 * cent) + 5) / 25) - 5       // 400 year cycle
            - (((3 * cent) / 4) - 12)) % 30    //Leap year correction
        if (epact <= 0){
            epact += 30                 // Age range is 1 .. 30
        }
        if ((epact == 25 && golden > 11) || epact == 24){
            epact+=1
        }
    
    
        // Calculate the phase, using the magic numbers defined above.
        // Note that (phase and 7) is equivalent to (phase mod 8) and
        // is needed on two days per year (when the algorithm yields 8).
    
        phase = (((((diy + epact) * 6) + 11) % 177) / 22) & 7;
    
        return(phase);
    }
    
    // daysInMonth
    //
    // Returns the number of days in a month given the month and the year.
    
    func isLeapYearP(year: Int) -> Bool {
        return ((year % 4 == 0) &&
            ((year % 400 == 0) || (year % 100 != 0)))
    }
    
    func daysInMonth(month:Int, year:Int) -> Int {
        var result = 31
        let isLeap = isLeapYearP(year: year)
        switch month{
        case 4:
            result = 30
        case 6:
            result = 30
        case 9:
            result = 30
        case 11:
            result = 30
        case 2:
            if (isLeap) {
                result = 29
            }else{
                result = 28
            }
        default:
            result = 31
        }
        return result
    }
    
    func phaseName(phase: Int) -> String {
        return moonPhaseName[phase]
    }
}
