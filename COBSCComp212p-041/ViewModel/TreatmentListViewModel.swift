//
//  TreatmentListViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class TreatmentListViewModel: ObservableObject {
    @Published var treatments: [TreatmentModel] = []

    func fetch() {
        Firestore.firestore().collection("treatments").getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            self.treatments = docs.compactMap { try? $0.data(as: TreatmentModel.self) }
        }
    }
}
