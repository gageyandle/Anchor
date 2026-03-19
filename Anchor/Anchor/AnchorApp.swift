import SwiftUI

@main
struct AnchorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Creates the SwiftData store on disk and injects it into
        // the environment so any view can access it via @Query or
        // @Environment(\.modelContext)
        .modelContainer(for: Priority.self)
    }
}
