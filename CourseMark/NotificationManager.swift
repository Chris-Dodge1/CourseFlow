import Foundation
import UserNotifications

struct NotificationManager {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error {
                print("Notification permission error: \(error)")
            }

            print("Notification permission granted: \(granted)")
        }
    }

    static func scheduleAssignmentReminders(
        for assignments: [Assignment],
        remindersEnabled: Bool,
        reminderTime: Date,
        reminderOffsetDays: Int
    ) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: assignments.map { "assignment-\($0.id.uuidString)" }
        )

        guard remindersEnabled else { return }

        for assignment in assignments where !assignment.isCompleted {
            scheduleReminder(
                for: assignment,
                reminderTime: reminderTime,
                reminderOffsetDays: reminderOffsetDays
            )
        }
    }

    private static func scheduleReminder(
        for assignment: Assignment,
        reminderTime: Date,
        reminderOffsetDays: Int
    ) {
        let calendar = Calendar.current

        guard let reminderBaseDate = calendar.date(
            byAdding: .day,
            value: -reminderOffsetDays,
            to: assignment.dueDate
        ) else {
            return
        }

        let timeComponents = calendar.dateComponents([.hour, .minute], from: reminderTime)

        guard let hour = timeComponents.hour,
              let minute = timeComponents.minute,
              let reminderDate = calendar.date(
                bySettingHour: hour,
                minute: minute,
                second: 0,
                of: reminderBaseDate
              ) else {
            return
        }

        guard reminderDate > Date() else {
            return
        }

        let content = UNMutableNotificationContent()
        content.title = reminderOffsetDays == 0 ? "Assignment Due Today" : "Assignment Coming Up"
        content.body = reminderMessage(for: assignment, reminderOffsetDays: reminderOffsetDays)
        content.sound = .default

        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: reminderDate
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: "assignment-\(assignment.id.uuidString)",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print("Failed to schedule reminder: \(error)")
            }
        }
    }

    private static func reminderMessage(for assignment: Assignment, reminderOffsetDays: Int) -> String {
        if reminderOffsetDays == 0 {
            return "\(assignment.title) is due today for \(assignment.courseName)."
        } else if reminderOffsetDays == 1 {
            return "\(assignment.title) is due tomorrow for \(assignment.courseName)."
        } else {
            return "\(assignment.title) is due in \(reminderOffsetDays) days for \(assignment.courseName)."
        }
    }
}
