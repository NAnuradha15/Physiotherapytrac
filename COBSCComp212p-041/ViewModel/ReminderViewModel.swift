//
//  ReminderViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseFirestore

class ReminderViewModel: ObservableObject {
    @Published var reminders: [Appointment] = []

    func fetchReminders() {
        Firestore.firestore().collection("appointments").getDocuments { snapshot, _ in
            if let docs = snapshot?.documents {
                self.reminders = docs.map {
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
