//
//  RemindersView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI
import FirebaseFirestore

struct RemindersView: View {
    @State private var appointments: [AppointmentModel] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack {
                Text("Remindings")
                    .fontWeight(.bold)
                    .font(.system(size: 28))
                    .foregroundColor(Color.bgBlack)
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 10)
            
            
            ForEach(appointments) { appointment in
                VStack(alignment: .leading) {
                    Text(appointment.patientName).bold()
                    Text(appointment.location)
                    HStack {
                        Text("Start : \(formatTime(from: appointment.startTime))").foregroundColor(.blue)
                        Spacer()
                        Text("Date : \(formatDate(from: appointment.date))").foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 2)
            }
            .background(Color.bgGray)
            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity)
        .onAppear { fetchAppointments() }
        .background(Color.bgGray)
    }
    
    func fetchAppointments() {
        Firestore.firestore().collection("appointments").getDocuments { snapshot, _ in
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
    RemindersView()
}
