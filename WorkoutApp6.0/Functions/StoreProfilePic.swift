//
//  StoreProfilePic.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/29/22.
//

import Foundation
import SwiftUI


func storeProfilePic(_ profilePic: UIImage?, completion: @escaping () -> () ) {
    // Gets current User ID
    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
    // Gets current User Profile Pic, compresses, and converts it to JPEG
    guard let imageData = profilePic?.jpegData(compressionQuality: 0.5) else { return }
    
    let ref = FirebaseManager.shared.storage.reference(withPath: uid)
    // Attempts to store data into Firebase storage
    ref.putData(imageData, metadata: nil, completion: { metadata, err in
        if let err = err {
            print("Failed to push image to storage\n\(err)")
            return
        }
        // Attempts to retrieve download URL for image
        ref.downloadURL(completion: { url, err in
            if let err = err {
                print("Failed to retrieve download URL\n\(err)")
                return
            }
            guard let url = url else { return }
            // Stores download URL into Firebase storage under user's information
            updateUserInfo(updatedField: "ProfilePicURL", info: url.absoluteString, infoType: String.self)
            completion()

        })
    })
}
