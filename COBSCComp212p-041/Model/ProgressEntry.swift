//
//  ProgressEntry.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import UIKit
import FirebaseFirestore

struct ProgressEntry: Identifiable, Codable {
    @DocumentID var id: String?
    var treatmentName: String
    var patientID: String
    var completed: Int
    var total: Int
    var updated: Date
}
