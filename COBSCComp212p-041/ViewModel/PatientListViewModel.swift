//
//  PatientListViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseFirestore

class PatientListViewModel: ObservableObject {
    @Published var patients: [Patient] = []

    func fetchPatients() {
        Firestore.firestore().collection("patients").getDocuments { snapshot, _ in
            self.patients = snapshot?.documents.map {
                Patient(id: $0.documentID, name: $0["name"] as? String ?? "")
            } ?? []
        }
    }
}
