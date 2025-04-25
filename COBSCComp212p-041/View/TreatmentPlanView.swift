//
//  TreatmentPlanView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct TreatmentPlanView: View {
    @StateObject private var vm = TreatmentPlanViewModel()

    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack {
                    Text("Treatment Plan")
                        .fontWeight(.bold)
                        .font(.system(size: 28))
                        .foregroundColor(Color.bgBlack)
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 10)
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 15) {
                        
                        HStack(spacing: 15) {
                            TextField("Treatment Name", text: $vm.plan.treatmentName)
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
                            TextField("Patient Name", text: $vm.plan.patientID)
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
                            Stepper("Days: \(vm.plan.days)", value: $vm.plan.days)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        HStack(spacing: 15) {
                            TextField("How much Doing (Time)", text: $vm.plan.time)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        HStack(spacing: 15) {
                            Stepper("Count: \(vm.plan.count)", value: $vm.plan.count)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        Button {
                            vm.save()
                        } label: {
                            Text("Submit")
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
        
            if self.vm.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(
                        alert: self.$vm.message.alert,
                        error: self.$vm.message.error,
                        topic: self.$vm.message.topic,
                        loading: self.$vm.message.isLoading
                    )
                }
            }
        }
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    TreatmentPlanView()
}
