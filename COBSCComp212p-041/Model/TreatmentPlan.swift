//
//  TreatmentPlan.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct TreatmentPlan: Identifiable, Codable {
    @DocumentID var id: String?
    var treatmentName: String
    var patientID: String
    var days: Int
    var time: String
    var count: Int
}
