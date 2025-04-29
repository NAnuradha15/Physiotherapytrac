//
//  TreatmentPlanViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class TreatmentPlanViewModel: ObservableObject {
    @Published var plan = TreatmentPlan(treatmentName: "", patientID: "", days: 0, time: "", count: 0)
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false)
    @Published var treatmentPlans: [TreatmentPlan] = []

    func save() {
        self.message.alert.toggle()
        self.message.isLoading = true
        
        guard !plan.treatmentName.isEmpty, !plan.patientID.isEmpty, plan.days != 0, plan.count != 0,!plan.time.isEmpty else {
            self.message.topic = "Error"
            self.message.isLoading = false
            self.message.error = "All fields are required."
            return
        }
        
        do {
            try Firestore.firestore().collection("treatmentPlans").addDocument(from: plan)
            self.message.isLoading = false
            self.message.error = "Treatment plan created successfully."
            self.message.topic = "Success"
            plan = TreatmentPlan(treatmentName: "", patientID: "", days: 0, time: "", count: 0)
        } catch {
            print("Error saving plan: \(error)")
        }
    }
    
    func fetchPlans() {
        do {
            Firestore.firestore().collection("treatmentPlans").order(by: "createdAt", descending: true).addSnapshotListener { (querySnapshot, error) in
             if let querySnapshot = querySnapshot {
                 self.treatmentPlans = querySnapshot.documents.compactMap { document -> TreatmentPlan? in
                     try? document.data(as: TreatmentPlan.self)
                 }
             }
         }
        } 
     }
}
