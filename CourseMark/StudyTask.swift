import Foundation

struct StudyTask: Identifiable, Hashable {
    let id: String
    var title: String
    var courseName: String
    var date: Date
    var isCompleted: Bool = false
}
