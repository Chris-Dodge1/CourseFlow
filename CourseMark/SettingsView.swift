import SwiftUI

struct SettingsView: View {
    @Binding var remindersEnabled: Bool
    @Binding var reminderTime: Date
    @Binding var reminderOffsetDays: Int

    let reminderOptions = [
        0: "On due date",
        1: "1 day before",
        2: "2 days before"
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Reminders") {
                    Toggle("Enable Reminders", isOn: $remindersEnabled)

                    Picker("Remind Me", selection: $reminderOffsetDays) {
                        ForEach([0, 1, 2], id: \.self) { days in
                            Text(reminderOptions[days] ?? "On due date")
                                .tag(days)
                        }
                    }
                    .disabled(!remindersEnabled)

                    DatePicker(
                        "Reminder Time",
                        selection: $reminderTime,
                        displayedComponents: .hourAndMinute
                    )
                    .disabled(!remindersEnabled)
                }

                Section("About") {
                    Text("CourseMark")
                    Text("Academic planner with assignments, study tasks, calendar tracking, and reminders.")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(
        remindersEnabled: .constant(true),
        reminderTime: .constant(Date()),
        reminderOffsetDays: .constant(1)
    )
}
