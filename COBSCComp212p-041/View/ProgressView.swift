//
//  ProgressView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct ProgressNewView: View {
    @StateObject private var vm = ProgressViewModel()
    @State private var patientID = ""

    var body: some View {
        VStack {
            TextField("Patient ID", text: $patientID)
                .padding()
            Button("Load Progress") {
                vm.fetch(for: patientID)
            }
            List(vm.entries) { entry in
                VStack(alignment: .leading) {
                    Text(entry.treatmentName)
                    Text("\(entry.completed)/\(entry.total)")
                    Text("Updated: \(entry.updated.formatted())")
                }
            }
        }
        .navigationTitle("Progress Tracker")
        .background(Color.bgGray)
    }
}

#Preview {
    ProgressView()
}
