import Foundation

struct Course: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var instructor: String
    var colorName: String
}
