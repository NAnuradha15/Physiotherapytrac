//
//  DashboardViewModel.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2024-10-27.
//

import FirebaseFirestore
import FirebaseAuth

class DashboardViewModel: ObservableObject {
    @Published var openTickets: Int = 0
    @Published var pendingTickets: Int = 0
//    @Published var recentTickets: [Ticket] = []
    
    let userId = Auth.auth().currentUser!.uid
    
    private var db = Firestore.firestore()
    
    func fetchTicketCounts() {
        
        db.collection("Tickets").whereField("status", isEqualTo: "open").whereField("assigned_to", isEqualTo: userId).getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                self.openTickets = documents.count
            }
        }
        
        db.collection("Tickets").whereField("status", isEqualTo: "pending").whereField("assigned_to", isEqualTo: userId).getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                self.pendingTickets = documents.count
            }
        }
    }
    
    func fetchAdminTicketCounts() {
        
        db.collection("Tickets").whereField("status", isEqualTo: "open").getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                self.openTickets = documents.count
            }
        }
        
        db.collection("Tickets").whereField("status", isEqualTo: "pending").getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                self.pendingTickets = documents.count
            }
        }
    }
    
//    func fetchRecentTickets() {
//        recentTickets = []
//        // Query Firestore for the most recent 5 tickets created by the current user
//        db.collection("Tickets")
//            .whereField("assigned_to", isEqualTo: userId) // Filter by current user
//            .limit(to: 5) // Limit to 5 most recent tickets
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching recent tickets: \(error)")
//                    return
//                }
//                
//                if let documents = snapshot?.documents {
//                    // Map Firestore documents to `Ticket` model objects
//                    self.recentTickets = documents.compactMap { doc -> Ticket? in
//                        try? doc.data(as: Ticket.self)
//                    }
//                }
//            }
//    }
//    
//    func fetchHistory() {
//        recentTickets = []
//        db.collection("Tickets")
//            .whereField("created_by", isEqualTo: userId)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching recent tickets: \(error)")
//                    return
//                }
//                
//                if let documents = snapshot?.documents {
//                    self.recentTickets = documents.compactMap { doc -> Ticket? in
//                        try? doc.data(as: Ticket.self)
//                    }
//                }
//            }
//    }
//        
//    func fetchOpenPendingTicktes(isOpenTickets: Bool) {
//        recentTickets = []
//        db.collection("Tickets")
//            .whereField("status", isEqualTo: isOpenTickets ? "open" : "pending")
//            .whereField("assigned_to", isEqualTo: userId)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching recent tickets: \(error)")
//                    return
//                }
//                
//                if let documents = snapshot?.documents {
//                    self.recentTickets = documents.compactMap { doc -> Ticket? in
//                        try? doc.data(as: Ticket.self)
//                    }
//                }
//            }
//    }
//    
//    func fetchAdminOpenPendingTicktes(isOpenTickets: Bool) {
//        recentTickets = []
//        db.collection("Tickets")
//            .whereField("status", isEqualTo: isOpenTickets ? "open" : "pending")
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching recent tickets: \(error)")
//                    return
//                }
//                
//                if let documents = snapshot?.documents {
//                    self.recentTickets = documents.compactMap { doc -> Ticket? in
//                        try? doc.data(as: Ticket.self)
//                    }
//                }
//            }
//    }
//    
//    
//    
//    func fetchAdminHistory() {
//        recentTickets = []
//        db.collection("Tickets")
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching recent tickets: \(error)")
//                    return
//                }
//                
//                if let documents = snapshot?.documents {
//                    self.recentTickets = documents.compactMap { doc -> Ticket? in
//                        try? doc.data(as: Ticket.self)
//                    }
//                }
//            }
//    }
}
