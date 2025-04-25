//
//  AuthViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-10-27.
//

import SwiftUI
import FirebaseAuth
import LocalAuthentication
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticated = false
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false)
    @AppStorage("current_status") var status = false
    @AppStorage("isAdministrator") var isAdmin:Bool = false
    let defaults = UserDefaults.standard
    @Published var login = LoginModel(email: "", pass: "")
    @Published var registration = UserRegisterModel(username: "", mobile: "", email: "", pass: "", isBiometric: false)
    @Published var updateUser = UserModel(username: UserDefaults.standard.string(forKey: "username") ?? "", mobile: UserDefaults.standard.string(forKey: "userMobile") ?? "", email: UserDefaults.standard.string(forKey: "userEmail") ?? "", isBiometric: UserDefaults.standard.bool(forKey: "userIsBiometric"))
    
    // Sign in using Firebase Authentication
    func signIn() {
        self.message.alert.toggle()
        self.message.isLoading = true
        if(email == "admin@gmail.com" && password == "123456") {
            self.message.isLoading = false
            self.status = false
            self.isAdmin = true
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password) { (res , err)  in
                if err != nil {
                    self.message.isLoading = false
                    self.message.error = err!.localizedDescription
                }else{
                    
                    fetchUser() { userDetails in
                        self.defaults.setValue(userDetails.username, forKey: "username")
                        self.defaults.setValue(userDetails.mobile, forKey: "userMobile")
                        self.defaults.setValue(userDetails.isBiometric, forKey: "userIsBiometric")
                        self.defaults.setValue(self.email, forKey: "userEmail")
                        self.defaults.setValue(self.password, forKey: "userPassword")
                        self.message.alert.toggle()
                        self.message.isLoading = false
                        self.status = true
                        self.isAdmin = false
                    }

                }
            }
        }
    }
    
    func registerUser() {
        self.message.alert.toggle()
        self.message.isLoading = true
        
        guard !registration.username.isEmpty, !registration.email.isEmpty, !registration.pass.isEmpty, !registration.mobile.isEmpty else {
            self.message.isLoading = false
            self.message.error = "All fields are required."
            return
        }

        // Register user with Firebase Authentication
        Auth.auth().createUser(withEmail: registration.email, password: registration.pass) { result, error in
            if let error = error {
                self.message.isLoading = false
                self.message.error = "Registration failed: \(error.localizedDescription)"
                return
            }

            guard let userId = result?.user.uid else { return }
            
            
            do {
                let db = Firestore.firestore()
                try db.collection("Users").document(userId).setData(from: self.registration)
                self.message.isLoading = false
                self.message.error = "Account created successfully."
                self.message.topic = "Success"
                self.registration = UserRegisterModel(username: "", mobile: "", email: "", pass: "", isBiometric: false)
            } catch {
                self.message.isLoading = false
                self.message.error = "Failed to save user details: \(error.localizedDescription)"
            }
        }
    }
    
    // Biometric Login
    func biometricLogin() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Use Face ID or Touch ID to log in."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        if let email = UserDefaults.standard.string(forKey: "userEmail"),
                           let password = UserDefaults.standard.string(forKey: "userPassword") {
                            self.email = email
                            self.password = password
                            self.signIn() // Perform Firebase login
                        } else {
                            self.message.alert = true
                            self.message.error = "No saved credentials found."
                        }
                    } else {
                        self.message.alert = true
                        self.message.error = "Biometric authentication failed."
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.message.alert = true
                self.message.error = "Biometric authentication not available."
            }
        }
    }
    
    func updateUserProfile() {
        self.message.alert.toggle()
        self.message.isLoading = true
        
        guard !updateUser.username.isEmpty, !updateUser.email.isEmpty, !updateUser.mobile.isEmpty else {
            self.message.isLoading = false
            self.message.error = "All fields are required."
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let userRef = Firestore.firestore().collection("users").document(userId)

        userRef.updateData([
            "username": updateUser.username,
            "mobile": updateUser.mobile,
            "isBiometric": updateUser.isBiometric
        ]) { error in
            if let error = error {
                self.message.topic = "Error"
                self.message.isLoading = false
                self.message.error = "Registration failed: \(error.localizedDescription)"
                print("Error updating profile: \(error.localizedDescription)")
            } else {
                self.message.isLoading = false
                self.message.error = "Account updated successfully."
                self.message.topic = "Success"
                // Update local UserDefaults
                UserDefaults.standard.setValue(self.updateUser.username, forKey: "username")
                UserDefaults.standard.setValue(self.updateUser.mobile, forKey: "userMobile")
                UserDefaults.standard.setValue(self.updateUser.isBiometric, forKey: "userIsBiometric")
                print("Profile successfully updated.")
            }
        }
    }

    
    // Verify Forgot Password
    func verifyResetPassword(){
        if self.login.email != "" {
            self.resetPassword()
        }else{
            self.message.error = "Email ID is Empty"
            self.message.alert.toggle()
        }
    }

    // Send Forgotpassword Firebase request
    func resetPassword(){
        Auth.auth().sendPasswordReset(withEmail: self.login.email) { (err) in
            if err != nil {
                self.message.error = err!.localizedDescription
                self.message.alert.toggle()
                return
            }else{
                self.message.topic = "Information"
                self.message.error = "Password Reset Link has been sent successfully."
                self.message.alert.toggle()
            }
        }
    }
}
