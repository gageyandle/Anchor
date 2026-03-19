import SwiftUI

struct PriorityCard: View {
    let priority: Priority
    let onToggle: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onToggle) {
                Image(systemName: priority.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(priority.isCompleted ? .green : .secondary)
            }
            .buttonStyle(.plain)

            Text(priority.title)
                .font(.body)
                .strikethrough(priority.isCompleted, color: .secondary)
                .foregroundStyle(priority.isCompleted ? .secondary : .primary)

            Spacer()
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        .swipeActions(edge: .trailing) {
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
