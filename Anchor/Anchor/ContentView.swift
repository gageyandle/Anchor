import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MorningView()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                }

            FocusView()
                .tabItem {
                    Label("Focus", systemImage: "timer")
                }

            ReflectionView()
                .tabItem {
                    Label("Reflect", systemImage: "moon.stars")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Priority.self, inMemory: true)
}
