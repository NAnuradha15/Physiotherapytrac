//
//  PatientListView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct PatientListView: View {
    @StateObject var viewModel = PatientListViewModel()

    var body: some View {
        VStack {
            HStack {
                VStack { Image(systemName: "person"); Text("Patient") }
                VStack { Image(systemName: "person.crop.circle"); Text("User") }
            }

            ForEach(viewModel.patients) { patient in
                HStack {
                    Image(systemName: "person.fill")
                    Text(patient.name)
                    Spacer()
                    Button("View") { }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
        }
        .onAppear { viewModel.fetchPatients() }
        .padding()
        .background(Color.bgGray)
    }
}

#Preview {
    PatientListView()
}
