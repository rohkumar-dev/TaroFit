//
//  OrganizeTimer.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/28/22.
//

import Foundation


/// Formats seconds into mm:ss format
func organizeTimer(_ seconds: Int, showMinutes: Bool = true) -> String {
    let secondsLeft:Int = seconds % 60
    let minutes:Int = seconds / 60
    let secondsStr: String = (secondsLeft < 10 ? "0\(secondsLeft)"  : String(secondsLeft) )
    let minutesStr: String = (minutes < 10 ? "0\(minutes)"  : String(minutes) )
    
    return showMinutes ? minutesStr + ":" + secondsStr : secondsStr
}
