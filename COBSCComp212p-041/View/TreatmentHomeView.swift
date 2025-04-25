//
//  TreatmentHomeView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI
import FirebaseFirestore

struct TreatmentHomeView: View {
    @State private var appointments: [Appointment] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Treatment Organizing")
                    .font(.title)
                    .bold()

                HStack {
                    TreatmentCard(title: "New Treatment Attached", updated: "1 min ago", isTreatmentPlanOpen: false)
                        .padding(.horizontal,10)
                       
                    TreatmentCard(title: "Treatment Plan Create", updated: "1 min ago", isTreatmentPlanOpen: true)
                        .padding(.horizontal,10)
                }

                Text("Up Coming")
                    .font(.title2)
                    .bold()

                ForEach(appointments) { appointment in
                    VStack(alignment: .leading) {
                        Text(appointment.patientName).bold()
                        Text(appointment.location)
                        HStack {
                            Text("Start : \(formatTime(appointment.startTime))").foregroundColor(.blue)
                            Spacer()
                            Text("Date : \(formatDate(appointment.date))").foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 2)
                }
            }
            .padding(20)
        }
        .onAppear {
            fetchAppointments()
        }
        .background(Color.bgGray)
    }
    
    func fetchAppointments() {
        Firestore.firestore().collection("appointments").getDocuments { snapshot, _ in
            if let docs = snapshot?.documents {
                appointments = docs.map {
                    Appointment(id: $0.documentID,
                                patientName: $0["patientName"] as? String ?? "",
                                date: $0["date"] as? Date ?? Date(),
                                startTime:  $0["startTime"] as? Date ?? Date(),
                                endTime: $0["endTime"] as? Date ?? Date(),
                                location: $0["location"] as? String ?? "",
                                notify: $0["notify"] as? Bool ?? false)
                }
            }
        }
    }
}


#Preview {
    TreatmentHomeView()
}
