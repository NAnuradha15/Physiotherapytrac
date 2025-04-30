//
//  TreatmentPlanListView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-26.
//

import SwiftUI

struct TreatmentPlanListView: View {
    @ObservedObject private var viewModel = TreatmentPlanViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Treatment Plane")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink(destination: PatientProfileView() ) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)

                Spacer()
                
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                    
                    Text(viewModel.User.username)
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(radius: 1)
                }
                .padding(.top, 10)
                .padding(20)
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.treatmentPlans) { plan in
                        NavigationLink(destination: TreatmentInputView(treatment: plan)) {
                            TreatmentPlanCard(plan: plan)
                        }
                        
                    }
                }
                .padding()
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
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
            
            HStack {
                Spacer()
                Text("\(plan.count/2)/\(plan.count)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.black)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

