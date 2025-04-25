//
//  Treatment.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Treatment: Identifiable {
    var id: String
    var name: String
    var reason: String
    var bodyArea: String
    var steps: String
}

struct TreatmentModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var imageURL: String?
}
