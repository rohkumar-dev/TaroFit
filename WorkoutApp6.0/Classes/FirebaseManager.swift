//
//  FirebaseManager.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/29/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


// Class used for Firebase commands (allows use of realtime preview)
class FirebaseManager : NSObject {
    let auth : Auth
    let storage : Storage
    let firestore : Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
    }
}

// Template Function to update User info
func updateUserInfo<T>(updatedField:String, info:Any, infoType:T.Type) {
    // Gets current User ID
    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
    if let info = info as? T { // Checks to see if info is of the correct type
        
        let userInfo = [updatedField: info] // Dictionary storing new information
        // Updates userInfo into user's firestore file
        
        FirebaseManager.shared.firestore.collection("users").document(uid).updateData(userInfo) { err in
            if let err = err { print(err) }
        }
    }
    
}



