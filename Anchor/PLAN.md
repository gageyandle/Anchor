# Anchor — iOS App Plan

## The One-Line Pitch
A student productivity app built around *one intentional day*: 3 priorities, focused study sessions with app blocking, and a brief end-of-day reflection.

## The Core Problem
Students are distracted, not unproductive — they have the time, they just lose it to their phone. Anchor's differentiator is **constraint**: you can't add a 4th priority. That's a design decision, not a limitation.

## Target User
College/high school students aged 16–24. Price ceiling: $3.99/mo.

---

## MVP Feature Set (Ship This First)

### 1. Morning Anchor (3 Priorities)
- Each day starts blank
- User sets exactly 3 priorities (hard cap enforced in UI)
- Simple text input, no subtasks, no due dates
- Priorities carry over if not completed (with gentle nudge)

### 2. Focus Session
- Pomodoro-style timer (25 min work / 5 min break)
- User picks which priority they're working on
- App blocking via ScreenTime/FamilyControls API (Phase 2 — needs Apple entitlement)
- Phase 1: honor system + full-screen lock UI that's hard to exit

### 3. End-of-Day Reflection
- Triggered by notification at user-set time (default 9pm)
- 3 questions: What did you finish? What stopped you? What's one thing for tomorrow?
- Stored locally — no account required for MVP

### 4. Streak & Momentum
- Simple day streak for completing at least 1 priority
- Subtle, not gamified — students hate being patronized

---

## Phase 2 (Post-Launch)
- ScreenTime API integration (app blocking during focus)
- Widgets (home screen: today's 3 priorities)
- Live Activities (focus timer on Dynamic Island / lock screen)
- iCloud sync (for users with multiple devices)
- Paywall + StoreKit 2 subscription

---

## Monetization
- Free tier: full app, no streak history, no widgets
- Anchor Pro ($3.99/mo or $24.99/yr): streak history, widgets, Live Activities, themes
- Target: ~590 monthly subscribers to net ~$2k/mo after Apple's 15% cut

---

## Distribution
1. TikTok — "study with me" + "productivity for students" content
2. Reddit — r/college, r/productivity, r/studytips
3. Student Discord servers
4. App Store optimization (ASO) — keywords: study timer, focus app for students, pomodoro

---

## Tech Stack
- **Language:** Swift 5.9+
- **UI:** SwiftUI (no UIKit)
- **Storage:** @AppStorage (simple) → SwiftData (when you need relationships)
- **Notifications:** UNUserNotificationCenter
- **Subscriptions:** StoreKit 2
- **App Blocking:** FamilyControls / ScreenTime API (apply for entitlement early)
- **Minimum iOS:** iOS 17 (lets you use all modern SwiftUI features)

---

## Learning Path (Do This in Parallel)
1. **Now → Month 2:** 100 Days of SwiftUI — hacking with swift (free)
   - https://www.hackingwithswift.com/100/swiftui
2. **Day 60:** Start building Anchor alongside remaining lessons
3. **Month 3:** Polish MVP, submit to App Store
4. **Apply for ScreenTime entitlement** from Apple as soon as you have a working app concept

---

## File Structure (Xcode Project)
```
Anchor/
├── AnchorApp.swift          # App entry point
├── ContentView.swift        # Root navigation
├── Models/
│   ├── Priority.swift       # Priority model
│   ├── FocusSession.swift   # Focus session model
│   └── DayReflection.swift  # End-of-day reflection model
├── Views/
│   ├── Morning/
│   │   └── MorningView.swift    # Set 3 priorities
│   ├── Focus/
│   │   └── FocusView.swift      # Pomodoro timer
│   ├── Evening/
│   │   └── ReflectionView.swift # End-of-day reflection
│   └── Components/
│       └── PriorityCard.swift   # Reusable priority card
├── ViewModels/
│   ├── DayViewModel.swift   # Today's state
│   └── FocusViewModel.swift # Timer logic
└── Resources/
    └── Assets.xcassets
```

---

## Design Principles
1. **Constraint is a feature** — never let users add more than 3 priorities
2. **One screen at a time** — no cluttered dashboards
3. **Calm, not gamified** — no badges, no confetti, no leaderboards
4. **Fast to open** — the app should show today's state in under 1 second
5. **Works offline** — no account required, everything local for MVP

---

## Next Steps (In Order)
- [ ] Set up Xcode project (SwiftUI, iOS 17+)
- [ ] Build MorningView — enter 3 priorities, hard cap enforced
- [ ] Build FocusView — timer, select which priority you're working on
- [ ] Build ReflectionView — 3 end-of-day questions
- [ ] Wire up local notifications for morning prompt + evening reflection
- [ ] Add @AppStorage persistence so data survives app restarts
- [ ] TestFlight beta with 10 real students
- [ ] Apply for FamilyControls entitlement
- [ ] Add StoreKit 2 paywall
- [ ] App Store submission
