//
//  LoginView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-10-27.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = AuthViewModel()
    @State var visible = false
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                        Text("Hello")
                            .fontWeight(.bold)
                            .font(.system(size: 64))
                            .foregroundColor(Color.bgBlack)
                            .padding(.bottom, 30)
                    Text("Sign in to your account")
                        .fontWeight(.regular)
                        .font(.system(size: 18))
                        .foregroundColor(Color.bgBlack)
                    
                }.frame(height: getRect().height / 3.7)
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(spacing: 15) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color.black.opacity(0.7))
                            TextField("Email", text: self.$loginVM.email)
                                .textInputAutocapitalization(.never)
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
                                    TextField("Password", text: self.$loginVM.password)
                                        .textInputAutocapitalization(.never)
                                }else {
                                    SecureField("Password", text: self.$loginVM.password)
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
                        
                        HStack{
                            Spacer()
                            NavigationLink {
                                ForgotPasswordView()
                            } label: {
                                Text("Forget Password?")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                            }
                        }
                        .padding(.top, 10)
                        
                        Button {
                            loginVM.signIn()
                        } label: {
                            Text("SIGN IN")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("BGBlue"))
                        .cornerRadius(10)
                        .padding(.top, 15)
                        
                        HStack {
                            Spacer()
  
                                Text("Don't you have an account?")
                                NavigationLink(destination: RegisterView()) {
                                    Text(" Sign up")
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
    
                            Spacer()
                        }
                        .font(.system(size: 16))
                        .padding(.top, 10)

                        
                        
                        // Biometric Login Button
                        Button {
                            loginVM.biometricLogin()
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: "faceid")
                                    .font(.system(size: 65))
                                Image(systemName: "fingerprint")
                                    .font(.system(size: 65))
                                Spacer()
                            }
                            .foregroundColor(Color.bgBlack)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .cornerRadius(10)
                        .padding(.top, 15)
                        
                    }
                    .padding([.horizontal, .bottom], 20)
                    .padding(.top, 35)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color("BGGray"))
                
            
            if self.loginVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$loginVM.message.alert, error: self.$loginVM.message.error, topic: self.$loginVM.message.topic, loading: self.$loginVM.message.isLoading)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginView()
}
