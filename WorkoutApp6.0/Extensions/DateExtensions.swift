//
//  DateExtensions.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/26/22.
//

import Foundation

extension Date {
    func getDaysInMonth() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day-1, to: startDate)!
        }
    }
    
    /// Returns in format (Month, Year)
    func getMonthAndYearFromDate() -> String {
        let monthFormat = DateFormatter()
        monthFormat.dateFormat = "MMMM"
        let yearFormat = DateFormatter()
        yearFormat.dateFormat = "yyyy"
        
        return "\(monthFormat.string(from: self)) \(yearFormat.string(from: self))"
    }
    
    func formatDate() -> String {
        let date = DateFormatter()
        date.dateFormat = "MMMM dd"
        
        return date.string(from: self)
    }
    
    func getDay() -> Int? {
        let date = DateFormatter()
        date.dateFormat = "dd"
        
        return Int(date.string(from: self))
    }
    
}


struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
