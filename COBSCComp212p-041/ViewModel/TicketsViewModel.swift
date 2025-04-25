//
//  TicketsViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-11-02.
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class TicketsViewModel: ObservableObject {
    
    @Published var users: [User] = []
    let db = Firestore.firestore()
    
    func fetchUsers() {
        db.collection("Users").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.users = documents.compactMap { doc -> User? in
                    try? doc.data(as: User.self)
                }
            }
        }
    }
    
    func createTicket(title: String, description: String, status: String, assignedTo: String? = nil, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
            return
        }
        

        let newTicket: [String: Any] = [
            "title": title,
            "description": description,
            "status": status,
            "created_by": userId,
            "timestamp": Timestamp(),
            "assigned_to": assignedTo ?? ""
        ]
        
        db.collection("Tickets").addDocument(data: newTicket) { error in
            if let error = error {
                print("Error creating ticket: \(error)")
                completion(.failure(error))
            } else {
                print("Ticket successfully created")
                completion(.success(()))
            }
        }
    }
    
//    func fetchTicketCounts(for users: [UserTickets], completion: @escaping ([UserTickets]) -> Void) {
//        var updatedUsers = users
//        let group = DispatchGroup()
//
//        for (index, user) in users.enumerated() {
//            group.enter()
//
//            // Fetch "open" tickets for the user
//            db.collection("Tickets")
//                .whereField("created_by", isEqualTo: user.userId)
//                .whereField("status", isEqualTo: "open")
//                .getDocuments { snapshot, error in
//                    if let documents = snapshot?.documents {
//                        updatedUsers[index].openTickets = documents.count
//                    }
//                    group.leave()
//                }
//
//            group.enter()
//            // Fetch "pending" tickets for the user
//            db.collection("Tickets")
//                .whereField("created_by", isEqualTo: user.userId)
//                .whereField("status", isEqualTo: "pending")
//                .getDocuments { snapshot, error in
//                    if let documents = snapshot?.documents {
//                        updatedUsers[index].pendingTickets = documents.count
//                    }
//                    group.leave()
//                }
//        }
//
//        group.notify(queue: .main) {
//            completion(updatedUsers)
//        }
//    }
    
}
