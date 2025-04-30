//
//  PatientRegisterView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-11-16.
//

import SwiftUI

struct PatientRegisterView: View {
    @StateObject private var registerVM = AuthViewModel()
    @Environment(\.presentationMode) var present
    @State var visible = false
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    HStack(spacing: 20) {
                        Button(action: {
                            present.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.black)
                        })
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                    
                    HStack {
                        Text("Create Patient Account")
                            .fontWeight(.regular)
                            .font(.system(size: 28))
                            .foregroundColor(Color.bgBlack)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing: 15) {
                            
                            HStack(spacing: 15) {
                                Image(systemName: "person")
                                    .foregroundColor(Color.black.opacity(0.7))
                                TextField("Username", text: self.$registerVM.registration.username)
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
                                TextField("Email", text: self.$registerVM.registration.email)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.white.opacity(0.9))
                            )
                            .padding(.top, 15)
                            
                            HStack(spacing: 15){
                                
                                Button {
                                    self.visible.toggle()
                                } label: {
                                    Image(systemName: !self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.black.opacity(0.7))
                                }

                                VStack{
                                    if self.visible{
                                        TextField("Password", text: self.$registerVM.registration.pass)
                                            .textInputAutocapitalization(.never)
                                    }else {
                                        SecureField("Password", text: self.$registerVM.registration.pass)
                                            .textInputAutocapitalization(.never)
                                    }
                                }
                                
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
                                TextField("Mobile", text: self.$registerVM.registration.mobile)
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
                                Toggle("Biometric", isOn: $registerVM.registration.isBiometric)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white.opacity(0.9))
                            )
                            .padding(.top, 15)
                            
                            Button {
                                registerVM.registerPatientUser()
                            } label: {
                                Text("Register")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color("BGBlue"))
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
                
            
            if self.registerVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$registerVM.message.alert, error: self.$registerVM.message.error, topic: self.$registerVM.message.topic, loading: self.$registerVM.message.isLoading)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RegisterView()
}
