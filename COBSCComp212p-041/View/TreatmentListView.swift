//
//  TreatmentListView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct TreatmentListView: View {
    @StateObject private var vm = TreatmentListViewModel()

    var body: some View {
        List(vm.treatments) { treatment in
//            NavigationLink(destination: TreatmentDetailView(treatment: treatment)) {
//                VStack(alignment: .leading) {
//                    Text(treatment.name).bold()
//                    Text(treatment.description.prefix(100) + "...")
//                }
//            }
        }
        .onAppear { vm.fetch() }
        .navigationTitle("Treatments")
        .background(Color.bgGray)
    }
}

#Preview {
    TreatmentListView()
}
