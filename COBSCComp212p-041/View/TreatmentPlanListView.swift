//
//  TreatmentPlanListView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-26.
//

import SwiftUI

struct TreatmentPlanListView: View {
    @StateObject private var viewModel = TreatmentPlanViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.treatmentPlans) { plan in
                        TreatmentPlanCard(plan: plan)
                    }
                }
                .padding()
            }
            .navigationTitle("Treatment Plan")
            .onAppear {
                viewModel.fetchPlans()
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    TreatmentPlanListView()
}

struct TreatmentPlanCard: View {
    var plan: TreatmentPlan

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(plan.treatmentName)
                .font(.headline)
            
            Text("Last Updated: \(plan.time)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text("\(plan.count/2)/\(plan.count)")
                .font(.title2)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

