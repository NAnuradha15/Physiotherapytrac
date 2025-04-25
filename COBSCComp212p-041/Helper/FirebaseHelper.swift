//
//  FirebaseHelper.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-10-30.
//

import SwiftUI
import Firebase
import FirebaseAuth

let ref = Firestore.firestore()



func fetchUser(completion: @escaping (UserModel) -> ()){
    let uid = Auth.auth().currentUser!.uid
    ref.collection("Users").document(uid).getDocument{ (doc, err) in
        guard let user = doc else { return }
        
        let username = user.data()?["username"] as! String
        let mobile = user.data()?["mobile"] as! String
        let email = user.data()?["email"] as! String
        let isBiometric = user.data()?["isBiometric"] as! Bool
         
        DispatchQueue.main.async {
            completion(UserModel(username: username, mobile: mobile, email: email, isBiometric: isBiometric))
        }
    }
}



func formatTimestamp(_ timestamp: Timestamp) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short   // e.g., Nov 11, 2023
    dateFormatter.timeStyle = .short    // e.g., 11:00 AM
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent formatting
    
    let date = timestamp.dateValue() // Convert Firestore Timestamp to Date
    return dateFormatter.string(from: date)
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd" // Example: 2025-10-01
    return formatter.string(from: date)
}

func formatTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a" // Example: 12:00 AM
    return formatter.string(from: date)
}
