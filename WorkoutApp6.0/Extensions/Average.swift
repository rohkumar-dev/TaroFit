//
//  Average.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/30/22.
//

import Foundation

extension Array where Element: BinaryFloatingPoint {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }

}
