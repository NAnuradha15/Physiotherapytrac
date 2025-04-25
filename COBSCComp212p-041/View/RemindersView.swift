//
//  RemindersView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI

struct RemindersView: View {
    @StateObject var viewModel = ReminderViewModel()

    var body: some View {
        List(viewModel.reminders) { reminder in
            VStack(alignment: .leading) {
                Text(reminder.patientName).bold()
                Text("Location: \(reminder.location)")
                Text("Start: \(reminder.time.formatted(date: .omitted, time: .shortened))")
                Text("Date: \(reminder.date.formatted(date: .long, time: .omitted))")
            }
        }
        .onAppear { viewModel.fetchReminders() }
        .background(Color.bgGray)
    }
}

#Preview {
    RemindersView()
}
