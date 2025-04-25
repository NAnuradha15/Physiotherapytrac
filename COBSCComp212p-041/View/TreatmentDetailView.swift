//
//  TreatmentDetailView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct TreatmentDetailView: View {
    var treatment: Treatment

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(treatment.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("Area: \(treatment.bodyArea)")
                    .font(.headline)
                
                Text("Reason: \(treatment.reason)")
                    .font(.body)
                
                Text("Steps: \(treatment.steps)")
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(treatment.name)
    }
}
