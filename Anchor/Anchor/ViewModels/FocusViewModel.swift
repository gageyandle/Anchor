import SwiftUI

// @MainActor ensures all UI state updates happen on the main thread —
// important because the timer fires from a background async context.
@MainActor
@Observable
class FocusViewModel {
    enum TimerState {
        case idle, running, paused, finished
    }

    var state: TimerState = .idle
    var totalSeconds: Int = 25 * 60
    var secondsRemaining: Int = 25 * 60

    // Replaces Combine's AnyCancellable — a Task is a unit of
    // async work that can be cancelled cleanly.
    private var timerTask: Task<Void, Never>?

    var progress: Double {
        guard totalSeconds > 0 else { return 0 }
        return Double(totalSeconds - secondsRemaining) / Double(totalSeconds)
    }

    var timeDisplay: String {
        String(format: "%02d:%02d", secondsRemaining / 60, secondsRemaining % 60)
    }

    func start() {
        state = .running
        timerTask = Task {
            while secondsRemaining > 0 {
                do {
                    // Suspend for 1 second. If the task is cancelled
                    // (pause/reset), sleep throws CancellationError
                    // and we exit immediately — no wasted ticks.
                    try await Task.sleep(for: .seconds(1))
                } catch {
                    return
                }
                secondsRemaining -= 1
            }
            state = .finished
        }
    }

    func pause() {
        timerTask?.cancel()
        timerTask = nil
        state = .paused
    }

    func resume() {
        start()
    }

    func reset() {
        timerTask?.cancel()
        timerTask = nil
        state = .idle
        secondsRemaining = totalSeconds
    }
}
