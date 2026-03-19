import Foundation

struct FocusSession: Identifiable, Codable {
    let id: UUID
    var priorityID: UUID?
    var durationMinutes: Int
    var startedAt: Date
    var completedAt: Date?

    var isCompleted: Bool { completedAt != nil }

    init(id: UUID = UUID(), priorityID: UUID? = nil, durationMinutes: Int = 25, startedAt: Date = .now) {
        self.id = id
        self.priorityID = priorityID
        self.durationMinutes = durationMinutes
        self.startedAt = startedAt
    }
}
