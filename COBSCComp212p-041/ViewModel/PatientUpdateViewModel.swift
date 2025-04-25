//
//  PatientUpdateViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

class PatientUpdateViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var password = ""
    @Published var biometrics = false

    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            if let data = snapshot?.data() {
                self.name = data["username"] as? String ?? ""
                self.email = data["email"] as? String ?? ""
                self.phone = data["phone"] as? String ?? ""
                self.biometrics = data["useBiometrics"] as? Bool ?? false
            }
        }
    }

    func updateUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let updatedData = [
            "username": name,
            "email": email,
            "phone": phone,
            "useBiometrics": biometrics
        ] as [String : Any]

        Firestore.firestore().collection("users").document(uid).updateData(updatedData)
    }
}
