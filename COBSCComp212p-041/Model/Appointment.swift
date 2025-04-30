//
//  Appointment.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Appointment: Codable {
    var patientName: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var location: String
    var notify: Bool
}

struct AppointmentModel: Identifiable, Codable {
    @DocumentID var id: String?
    var patientName: String
    var date: Timestamp
    var startTime: Timestamp
    var endTime: Timestamp
    var location: String
    var notify: Bool
}

struct AppointmentArrange: Codable {
    var patientName: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var location: String
    var notify: Bool
}
