//
//  PatientUpdateView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct PatientUpdateView: View {
    @StateObject private var viewModel = PatientUpdateViewModel()

    var body: some View {
        VStack(spacing: 16) {
            TextField("Name", text: $viewModel.name)
            SecureField("Password", text: $viewModel.password)
            TextField("Email", text: $viewModel.email)
            TextField("Phone", text: $viewModel.phone)
            Toggle("Biometrics", isOn: $viewModel.biometrics)

            Button("Update") {
                viewModel.updateUser()
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear { viewModel.fetchUserData() }
        .padding()
        .background(Color.bgGray)
    }
}

#Preview {
    PatientUpdateView()
}
