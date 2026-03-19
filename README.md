# Anchor

> A student productivity app built around one intentional day.

Most productivity apps let you add infinite tasks. Anchor refuses to. You get **3 priorities**, a **focus timer**, and a **nightly reflection** nothing more. The constraint is the point.

---

## Features

| Tab | What it does |
|-----|-------------|
| **Today** | Set up to 3 priorities for the day. Hard cap, no exceptions. |
| **Focus** | 25-minute Pomodoro timer. Pick a priority, lock in, get it done. |
| **Reflect** | 3 end-of-day questions. Takes 2 minutes. Builds self-awareness over time. |

---

## Tech Stack

- **Swift 5.9+** / **SwiftUI**
- **SwiftData** on-device persistence, no account required
- **Swift Concurrency** (`async/await`) powers the focus timer
- **Minimum iOS:** 17.0

---

## Project Structure

```
Anchor/
├── AnchorApp.swift                   # @main entry point, ModelContainer setup
├── ContentView.swift                 # TabView root
│
├── Models/
│   ├── Priority.swift                # @Model SwiftData entity
│   ├── FocusSession.swift            # Session record (Phase 2)
│   └── DayReflection.swift          # Reflection record
│
├── ViewModels/
│   └── FocusViewModel.swift          # Pomodoro timer (async/await)
│
└── Views/
    ├── Morning/
    │   └── MorningView.swift         # Set today's 3 priorities
    ├── Focus/
    │   └── FocusView.swift           # Timer + priority picker
    ├── Evening/
    │   └── ReflectionView.swift      # End-of-day reflection
    └── Components/
        └── PriorityCard.swift        # Reusable priority row
```

---

## Getting Started

**Requirements:** Mac with Xcode 15+, iOS 17+ simulator or physical device.

1. Clone the repo
2. Open Xcode → **File → New → Project → App**
   - Product Name: `Anchor`
   - Interface: `SwiftUI`
   - Minimum Deployments: `iOS 17`
3. Replace the generated files with the files in `Anchor/`
4. Press **⌘R** to build and run

---

## Roadmap

### MVP (current)
- [x] 3-priority cap enforced in UI and data layer
- [x] Pomodoro focus timer with pause/resume
- [ ] End-of-day reflection with local persistence
- [x] SwiftData on-device storage

### Phase 2
- [ ] Local notifications morning prompt + evening reflection reminder
- [ ] Home screen widget show today's 3 priorities
- [ ] ScreenTime / FamilyControls API actual app blocking during focus sessions *(requires Apple entitlement)*
- [ ] Live Activities focus timer on lock screen / Dynamic Island

### Phase 3
- [ ] StoreKit 2 subscription Anchor Pro ($3.99/mo or $24.99/yr)
- [ ] iCloud sync
- [ ] Streak tracking

---

## Design Principles

1. **Constraint is a feature** 3 priorities, no more, ever
2. **One screen at a time** no dashboards
3. **Calm, not gamified** no badges, no confetti, no streaks on the home screen
4. **Offline first** everything works without an internet connection
5. **Fast to open** today's state visible in under 1 second

---

## Learning Resources

- [100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) - free, structured, the best place to start
- [SwiftData documentation](https://developer.apple.com/documentation/swiftdata)
- [Meet SwiftData - WWDC23](https://developer.apple.com/videos/play/wwdc2023/10187/)
- [Swift by Sundell](https://www.swiftbysundell.com) - deeper dives once you have the basics
