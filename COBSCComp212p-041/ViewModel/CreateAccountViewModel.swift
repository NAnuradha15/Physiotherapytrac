//
//  CreateAccountViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CreateAccountViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var phone = ""
    @Published var useBiometrics = false
    @Published var isCreated = false

    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let uid = result?.user.uid {
                let userData: [String: Any] = [
                    "username": self.username,
                    "email": self.email,
                    "phone": self.phone,
                    "useBiometrics": self.useBiometrics
                ]
                Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                    DispatchQueue.main.async {
                        self.isCreated = (error == nil)
                    }
                }
            }
        }
    }
}
