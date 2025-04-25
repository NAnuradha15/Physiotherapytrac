//
//  ReminderViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseFirestore

class ReminderViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []

    func fetchReminders() {
        Firestore.firestore().collection("appointments").getDocuments { snapshot, _ in
            self.reminders = snapshot?.documents.compactMap {
                Reminder(
                    id: $0.documentID,
                    patientName: $0["patientName"] as? String ?? "",
                    date: ($0["date"] as? Timestamp)?.dateValue() ?? Date(),
                    time: ($0["startTime"] as? Timestamp)?.dateValue() ?? Date(),
                    location: $0["location"] as? String ?? ""
                )
            } ?? []
        }
    }
}
