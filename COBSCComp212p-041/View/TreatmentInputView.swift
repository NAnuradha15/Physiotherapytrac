//
//  TreatmentInputView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-30.
//


import SwiftUI

struct TreatmentInputView: View {
    let treatment: TreatmentPlan
    
    @State private var days = 2
    @State private var doingTime = Date()
    @State private var howMuchDoing = "1.00"
    @State private var count = 10
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Treatment Plane")
                    .font(.title)
                    .bold()
                
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                    
                    Text(UserDefaults.standard.string(forKey: "username") ?? "")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(radius: 1)
                }
                
                VStack {
                    Text("Treatment Name")
                        .font(.headline)
                    TextField("Treatment Name", text: .constant(treatment.treatmentName))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .disabled(true)
                    
                    Text("How many days")
                        .font(.headline)
                    Stepper(value: $days, in: 1...30) {
                        Text("\(days)")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 1)
                    
                    Text("How Much Doing")
                        .font(.headline)
                    HStack {
                        TextField("1.00", text: $howMuchDoing)
                            .keyboardType(.decimalPad)
                        DatePicker("", selection: $doingTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 1)
                    
                    Text("Number of Count")
                        .font(.headline)
                    Stepper(value: $count, in: 1...80) {
                        Text("\(count)")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 1)
                }
                .padding()
                
                Button(action: {
                    // Submit action
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}
