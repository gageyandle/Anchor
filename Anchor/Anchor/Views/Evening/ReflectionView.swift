import SwiftUI

struct ReflectionView: View {
    @AppStorage("reflection_whatFinished") private var whatFinished = ""
    @AppStorage("reflection_whatStopped") private var whatStopped = ""
    @AppStorage("reflection_tomorrow") private var tomorrow = ""
    @State private var saved = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Take 2 minutes.\nBe honest with yourself.")
                        .font(.title3.bold())
                        .padding(.horizontal)

                    ReflectionField(
                        question: "What did you actually finish today?",
                        placeholder: "Be specific...",
                        text: $whatFinished
                    )

                    ReflectionField(
                        question: "What stopped you or slowed you down?",
                        placeholder: "No judgment...",
                        text: $whatStopped
                    )

                    ReflectionField(
                        question: "One thing that matters most tomorrow?",
                        placeholder: "Just one...",
                        text: $tomorrow
                    )

                    Button {
                        save()
                    } label: {
                        Text(saved ? "Saved" : "Save Reflection")
                            .font(.body.bold())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(saved ? Color.green : Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal)
                    .animation(.easeInOut, value: saved)
                }
                .padding(.vertical)
            }
            .navigationTitle("Reflect")
        }
    }

    private func save() {
        // @AppStorage writes automatically on change; this just gives visual feedback
        saved = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            saved = false
        }
    }
}

struct ReflectionField: View {
    let question: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(question)
                .font(.subheadline.bold())
                .padding(.horizontal)

            TextEditor(text: $text)
                .frame(minHeight: 80)
                .padding(10)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .overlay(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(.tertiary)
                            .font(.subheadline)
                            .padding(.horizontal, 26)
                            .padding(.vertical, 18)
                            .allowsHitTesting(false)
                    }
                }
        }
    }
}

#Preview {
    ReflectionView()
}
