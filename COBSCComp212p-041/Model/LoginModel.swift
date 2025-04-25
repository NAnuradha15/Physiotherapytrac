//
//  LoginModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-10-30.
//

import Combine
import SwiftUI
import FirebaseFirestore


struct LoginModel {
    var email: String
    var pass: String
}

struct UserRegisterModel: Codable{
    var username : String
    var mobile : String
    var email : String
    var pass: String
    var isBiometric: Bool
}

struct UserModel{
    var username : String
    var mobile : String
    var email : String
    var isBiometric: Bool
}

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var username : String
    var mobile : String
    var email : String
    var isBiometric: Bool
}
