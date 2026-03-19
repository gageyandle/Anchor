import SwiftData
import Foundation

// @Model turns this into a SwiftData entity — replaces the old
// manual JSONEncoder + UserDefaults approach. Changes to any
// property are automatically tracked and persisted.
@Model
class Priority {
    var title: String
    var isCompleted: Bool
    var createdAt: Date

    init(title: String) {
        self.title = title
        self.isCompleted = false
        self.createdAt = .now
    }
}
