//
//  ReminderViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseFirestore

class ReminderViewModel: ObservableObject {
    @Published var reminders: [AppointmentModel] = []

    func fetchReminders() {
        Firestore.firestore().collection("appointments").getDocuments { snapshot, _ in
            if let docs = snapshot?.documents {
                self.reminders = docs.map {
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
