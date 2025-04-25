//
//  CreateAccountView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()

    var body: some View {
        VStack(spacing: 16) {
            TextField("Username", text: $viewModel.username)
            SecureField("Password", text: $viewModel.password)
            TextField("E-mail", text: $viewModel.email)
            TextField("Mobile", text: $viewModel.phone)
            Toggle("Biometrics", isOn: $viewModel.useBiometrics)

            Button("Submit") {
                viewModel.createAccount()
            }
            .buttonStyle(.borderedProminent)

            if viewModel.isCreated {
                VStack {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    Text("Created")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.bgGray)
    }
}

#Preview {
    CreateAccountView()
}
