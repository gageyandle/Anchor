import SwiftUI
import SwiftData

struct FocusView: View {
    @Query(sort: \Priority.createdAt) private var allPriorities: [Priority]
    @State private var viewModel = FocusViewModel()
    @State private var selectedPriority: Priority? = nil

    private var todaysPriorities: [Priority] {
        allPriorities.filter { Calendar.current.isDateInToday($0.createdAt) }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                // Priority picker
                if !todaysPriorities.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Working on...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(todaysPriorities) { priority in
                                    let isSelected = selectedPriority?.id == priority.id
                                    Text(priority.title)
                                        .font(.subheadline)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(isSelected ? Color.accentColor : Color.secondary.opacity(0.12))
                                        .foregroundStyle(isSelected ? .white : .primary)
                                        .clipShape(Capsule())
                                        .onTapGesture {
                                            selectedPriority = priority
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }

                // Timer ring
                ZStack {
                    Circle()
                        .stroke(Color.secondary.opacity(0.15), lineWidth: 12)

                    Circle()
                        .trim(from: 0, to: viewModel.progress)
                        .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: viewModel.progress)

                    VStack(spacing: 4) {
                        Text(viewModel.timeDisplay)
                            .font(.system(size: 52, weight: .light, design: .monospaced))

                        if viewModel.state == .finished {
                            Text("Session complete!")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .frame(width: 240, height: 240)

                // Controls
                HStack(spacing: 24) {
                    switch viewModel.state {
                    case .idle:
                        Button("Start") { viewModel.start() }
                            .buttonStyle(FocusButtonStyle(isPrimary: true))

                    case .running:
                        Button("Pause") { viewModel.pause() }
                            .buttonStyle(FocusButtonStyle(isPrimary: false))
                        Button("Cancel") { viewModel.reset() }
                            .buttonStyle(FocusButtonStyle(isPrimary: false))

                    case .paused:
                        Button("Resume") { viewModel.resume() }
                            .buttonStyle(FocusButtonStyle(isPrimary: true))
                        Button("Cancel") { viewModel.reset() }
                            .buttonStyle(FocusButtonStyle(isPrimary: false))

                    case .finished:
                        Button("New Session") { viewModel.reset() }
                            .buttonStyle(FocusButtonStyle(isPrimary: true))
                    }
                }

                Spacer()
            }
            .padding(.top, 32)
            .navigationTitle("Focus")
        }
    }
}

struct FocusButtonStyle: ButtonStyle {
    let isPrimary: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.bold())
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .background(isPrimary ? Color.accentColor : Color.secondary.opacity(0.15))
            .foregroundStyle(isPrimary ? .white : .primary)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    FocusView()
        .modelContainer(for: Priority.self, inMemory: true)
}
