//
//  ProgressViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProgressViewModel: ObservableObject {
    @Published var entries: [ProgressEntry] = []

    func fetch(for patientID: String) {
        Firestore.firestore().collection("progress")
            .whereField("patientID", isEqualTo: patientID)
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                self.entries = docs.compactMap { try? $0.data(as: ProgressEntry.self) }
            }
    }
}
