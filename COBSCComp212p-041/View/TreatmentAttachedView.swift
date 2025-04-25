//
//  TreatmentAttachedView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI
import FirebaseFirestore

struct TreatmentAttachedView: View {
    @State private var treatmentName = ""
    @State private var bodyArea = ""
    @State private var reason = ""
    @State private var steps = ""
    
    @State private var searchText = ""
    @State private var treatments: [Treatment] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Treatment Attached")
                    .font(.title)
                    .bold()

                Group {
                    CustomTextField(placeholder: "Treatment Name", text: $treatmentName)
                    CustomTextField(placeholder: "Given Area about body", text: $bodyArea)
                    CustomTextField(placeholder: "Reason For Given", text: $reason)
                    CustomTextField(placeholder: "Steps, How to Doing", text: $steps)
                }

                Button("Submit") {
                    addTreatment()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color("BGBlue"))
                .foregroundColor(.white)
                .cornerRadius(10)

                Text("Treatment")
                    .font(.title2)
                    .bold()

                CustomTextField(placeholder: "Search", text: $searchText)

                ForEach(treatments.filter {
                    searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
                }) { treatment in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(treatment.name).bold()
                            Text(treatment.reason)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        NavigationLink(destination: TreatmentDetailView(treatment: treatment)) {
                            Text("View")
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color("BGBlue"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, 15)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 2)
                }
            }
            .padding()
        }
        .onAppear {
            fetchTreatments()
        }
        .background(Color.bgGray)
    }

    func addTreatment() {
        let db = Firestore.firestore()
        let treatment = [
            "name": treatmentName,
            "bodyArea": bodyArea,
            "reason": reason,
            "steps": steps
        ]
        db.collection("treatments").addDocument(data: treatment) { err in
            if err == nil {
                treatmentName = ""
                bodyArea = ""
                reason = ""
                steps = ""
                fetchTreatments()
            }
        }
    }

    func fetchTreatments() {
        Firestore.firestore().collection("treatments").getDocuments { snapshot, _ in
            if let docs = snapshot?.documents {
                treatments = docs.map {
                    Treatment(id: $0.documentID,
                              name: $0["name"] as? String ?? "",
                              reason: $0["reason"] as? String ?? "",
                              bodyArea:  $0["bodyArea"] as? String ?? "",
                              steps: $0["steps"] as? String ?? "")
                }
            }
        }
    }
}





#Preview {
    TreatmentAttachedView()
}
