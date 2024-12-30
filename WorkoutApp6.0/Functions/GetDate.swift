//
//  GetDate.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/29/22.
//

import Foundation


func getDate(_ date: Date = Date(), format: String = "MM/dd/yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func getDate(_ dateStr: String, format: String = "MM/dd/yyyy") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: dateStr)
}
