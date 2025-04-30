//
//  PatientProfileView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct PatientProfileView: View {
    @StateObject private var profileVM = AuthViewModel()
    @State var visible = false
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    
                    HStack {
                        Text("Patient User Details")
                            .fontWeight(.regular)
                            .font(.system(size: 28))
                            .foregroundColor(Color.bgBlack)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing: 15) {
                            
                            HStack(spacing: 15) {
                                Image(systemName: "person")
                                    .foregroundColor(Color.black.opacity(0.7))
                                TextField("Username", text: self.$profileVM.updateUser.username)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.white.opacity(0.9))
                            )
                            .padding(.top, 15)
                            
                            HStack(spacing: 15) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color.black.opacity(0.7))
                                TextField("Email", text: self.$profileVM.updateUser.email)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.white.opacity(0.9))
                            )
                            .padding(.top, 15)
                            
                            HStack(spacing: 15) {
                                Image(systemName: "phone")
                                    .foregroundColor(Color.black.opacity(0.7))
                                TextField("Mobile", text: self.$profileVM.updateUser.mobile)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.white)
                            )
                            .padding(.top, 15)
                            
                            HStack(spacing: 15) {
                                Toggle("Biometric", isOn: $profileVM.updateUser.isBiometric)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white.opacity(0.9))
                            )
                            .padding(.top, 15)
                            
                            Button {
                                profileVM.updatePatientUserProfile()
                            } label: {
                                Text("Update")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color("BGBlue"))
                            .cornerRadius(10)
                            .padding(.top, 15)
                            
                            Button {
                                profileVM.logoutUser()
                            } label: {
                                Text("Logout")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color.bgWhite)
                            .cornerRadius(10)
                            .padding(.top, 15)
                        }
                        .padding([.horizontal, .bottom], 20)
                        .padding(.top, 35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
                

            }
            .background(Color.gray.opacity(0.2))
                
            
            if self.profileVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$profileVM.message.alert, error: self.$profileVM.message.error, topic: self.$profileVM.message.topic, loading: self.$profileVM.message.isLoading)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
