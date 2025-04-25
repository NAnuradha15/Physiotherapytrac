//
//  TreatmentCard.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct TreatmentCard: View {
    var title: String
    var updated: String
    var isTreatmentPlanOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).bold()
            Text("Last Updated: \(updated)")
                .font(.caption)
                .foregroundColor(.gray)
            
            NavigationLink(destination: isTreatmentPlanOpen ? AnyView(TreatmentPlanView()) : AnyView(TreatmentAttachedView())) {
                Text("Open")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.bgBlue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(width: 160)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}


struct AppointmentCard: View {
    var title: String
    var updated: String
    var isAppointmentOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).bold()
            Text("Last Updated: \(updated)")
                .font(.caption)
                .foregroundColor(.gray)
            
            NavigationLink(destination: isAppointmentOpen ? AnyView(AppointmentView()) : AnyView(LocationTrackerView())) {
                Text("Open")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.bgBlue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(width: 160)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}
