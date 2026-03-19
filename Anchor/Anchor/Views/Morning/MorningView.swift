import SwiftUI
import SwiftData

struct MorningView: View {
    // @Query watches the SwiftData store and rebuilds the view
    // automatically whenever priorities are added, changed, or deleted.
    @Query(sort: \Priority.createdAt) private var allPriorities: [Priority]

    // modelContext is the "pen" — you use it to insert or delete records.
    @Environment(\.modelContext) private var modelContext

    @State private var newPriorityText = ""
    @FocusState private var isInputFocused: Bool

    private let maxPriorities = 3

    // Filter to only today's priorities in memory — simple and fast
    // at the scale of this app (max 3 per day).
    private var todaysPriorities: [Priority] {
        allPriorities.filter { Calendar.current.isDateInToday($0.createdAt) }
    }

    private var canAddPriority: Bool {
        todaysPriorities.count < maxPriorities
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text(Date.now, format: .dateTime.weekday(.wide).month().day())
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("What matters today?")
                        .font(.title2.bold())
                }
                .padding(.horizontal)

                // Priority list + empty slots
                VStack(spacing: 12) {
                    ForEach(todaysPriorities) { priority in
                        PriorityCard(
                            priority: priority,
                            // SwiftData tracks property changes automatically —
                            // no manual save() call needed.
                            onToggle: { priority.isCompleted.toggle() },
                            onDelete: { modelContext.delete(priority) }
                        )
                    }

                    ForEach(todaysPriorities.count..<3, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary.opacity(0.2), style: StrokeStyle(lineWidth: 1.5, dash: [6]))
                            .frame(height: 60)
                            .overlay {
                                Text("Priority \(index + 1)")
                                    .font(.subheadline)
                                    .foregroundStyle(.tertiary)
                            }
                    }
                }
                .padding(.horizontal)

                // Add input
                if canAddPriority {
                    HStack(spacing: 12) {
                        TextField("Add a priority...", text: $newPriorityText)
                            .focused($isInputFocused)
                            .submitLabel(.done)
                            .onSubmit { addPriority() }

                        Button(action: addPriority) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                        .disabled(newPriorityText.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                } else {
                    Text("You're anchored for today.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                }

                Spacer()
            }
            .padding(.top)
            .navigationTitle("Anchor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func addPriority() {
        let trimmed = newPriorityText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty, canAddPriority else { return }
        // modelContext.insert() writes to the SwiftData store —
        // @Query picks up the change and rebuilds the view automatically.
        modelContext.insert(Priority(title: trimmed))
        newPriorityText = ""
        isInputFocused = false
    }
}

#Preview {
    MorningView()
        .modelContainer(for: Priority.self, inMemory: true)
}
