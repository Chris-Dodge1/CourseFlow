import Foundation

struct Assignment: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var courseName: String
    var dueDate: Date
    var priority: String
    var type: String
    var notes: String
    var isCompleted: Bool = false
}
