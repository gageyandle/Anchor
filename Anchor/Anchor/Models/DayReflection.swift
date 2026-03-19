import Foundation

struct DayReflection: Identifiable, Codable {
    let id: UUID
    var date: Date
    var whatFinished: String
    var whatStoppedYou: String
    var oneThingForTomorrow: String

    init(id: UUID = UUID(), date: Date = .now, whatFinished: String = "", whatStoppedYou: String = "", oneThingForTomorrow: String = "") {
        self.id = id
        self.date = date
        self.whatFinished = whatFinished
        self.whatStoppedYou = whatStoppedYou
        self.oneThingForTomorrow = oneThingForTomorrow
    }
}
