//
//  ConvertErrorMessage.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/29/22.
//

import Foundation

// Helper function to convert error codes to UI messages
func convertErrorMessage(_ err:NSError) -> String {
    var returnMessage:String = ""
    // Cases based off of error codes
    switch err.code {
    case 17026:
        returnMessage = "Password must be 6 characters long or more"
    case 17007:
        returnMessage = "Email is already in use"
    case 17008:
        returnMessage = "Invalid email"
    case 17009:
        returnMessage = "Incorrect password"
    case 17011:
        returnMessage = "No account associated with this email"
    default:
        returnMessage = "Unknown error"
    }
    return returnMessage
}
