//
//  AppointmentViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AppointmentViewModel: ObservableObject {
//    @Published var appointment = Appointment(patientID: "", date: Date(), startTime: "", endTime: "", location: "", remind: false)
    @Published var appointmentArrange = AppointmentArrange(patientName: "", date: Date(), startTime: Date(), endTime: Date(), location: "", notify: false)
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false)
    
//    func save() {
//        do {
//            try Firestore.firestore().collection("appointments").addDocument(from: appointment)
//        } catch {
//            print("Error saving appointment: \(error)")
//        }
//    }
    
    func saveAppointmentArrange() {
        self.message.alert.toggle()
        self.message.isLoading = true
        
        guard !appointmentArrange.patientName.isEmpty, !appointmentArrange.location.isEmpty, appointmentArrange.date != Date(), appointmentArrange.startTime != Date(), appointmentArrange.endTime != Date() else {
            self.message.topic = "Error"
            self.message.isLoading = false
            self.message.error = "All fields are required."
            return
        }
        
        do {
            try Firestore.firestore().collection("appointments").addDocument(from: appointmentArrange)
            self.message.isLoading = false
            self.message.error = "Appointment Arrange created successfully."
            self.message.topic = "Success"
            appointmentArrange = AppointmentArrange(patientName: "", date: Date(), startTime: Date(), endTime: Date(), location: "", notify: false)
        } catch {
            print("Error saving appointment: \(error)")
        }
    }
}

