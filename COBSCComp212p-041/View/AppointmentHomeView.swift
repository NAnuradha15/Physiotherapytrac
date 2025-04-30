//
//  AppointmentHomeView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI
import FirebaseFirestore

struct AppointmentHomeView: View {
    @State private var appointments: [AppointmentModel] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Appointment Plane")
                    .font(.title)
                    .bold()

                HStack {
                    AppointmentCard(title: "Appointment Arrange", updated: "1 min ago", isAppointmentOpen: true)
                        .padding(.horizontal,10)
                       
                    AppointmentCard(title: "Location Tracker", updated: "1 min ago", isAppointmentOpen: false)
                        .padding(.horizontal,10)
                }

                Text("Reminding")
                    .font(.title2)
                    .bold()

                ForEach(appointments) { appointment in
                    AppointmentCardView(appointment: appointment)
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
        Firestore.firestore()
            .collection("appointments")
            .whereField("notify", isEqualTo: true) // Filter here
            .getDocuments { snapshot, _ in
                if let docs = snapshot?.documents {
                    appointments = docs.map {
                        AppointmentModel(id: $0.documentID,
                                    patientName: $0["patientName"] as? String ?? "",
                                         date: $0["date"] as? Timestamp ?? Timestamp(),
                                    startTime:  $0["startTime"] as? Timestamp ?? Timestamp(),
                                    endTime: $0["endTime"] as? Timestamp ?? Timestamp(),
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
