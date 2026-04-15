# Calisthenics Coach

A guided calisthenics skill progression app for Android. Teaches handstands, L-sits, pull-ups, crow pose, and more — step by step, fully offline.

Built with Flutter · Riverpod · go_router · SharedPreferences

---

## Prerequisites

- macOS with [Homebrew](https://brew.sh) installed
- A physical Android device **or** an Android emulator (set up via Android Studio)

---

## 1 — Install Flutter

```bash
brew install --cask flutter
```

Verify the install:

```bash
flutter --version
```

---

## 2 — Install Android Studio

```bash
brew install --cask android-studio
```

Open Android Studio and complete the **Setup Wizard** — it installs the Android SDK, build tools, and emulator images automatically.

---

## 3 — Accept Android licenses

```bash
flutter doctor --android-licenses
```

Press `y` at every prompt.

---

## 4 — Verify everything is ready

```bash
flutter doctor
```

All items should show a green checkmark. Fix anything flagged before continuing.

---

## 5 — Clone / open the project

```bash
cd /Users/desktop/Documents/Work/projects/frontend-mobile
```

---

## 6 — Bootstrap Flutter project files

This generates the binary Gradle wrapper files that Flutter needs to build for Android. Run it once only.

```bash
flutter create . --project-name calisthenics_coach --org com.calisthenicscoach --platforms android
```

> If prompted about overwriting existing files, press **n** (no) to keep the app source files already in `lib/`.

---

## 7 — Install dependencies

```bash
flutter pub get
```

---

## 8 — Start an emulator (skip if using a physical device)

Open **Android Studio → Device Manager → Create Device**.  
Recommended: **Pixel 7, API 34**.  
Start the emulator, then return to the terminal.

To use a physical device instead, enable **USB Debugging** on the device and connect it via USB.

---

## 9 — Confirm Flutter sees your device

```bash
flutter devices
```

You should see your emulator or connected device listed.

---

## 10 — Run the app

```bash
flutter run
```

For a faster release build:

```bash
flutter run --release
```

---

## Folder structure

```
lib/
├── main.dart
├── core/
│   ├── navigation/        # go_router setup + bottom nav shell
│   ├── theme/             # Colors, typography (DM Sans), spacing, theme
│   └── widgets/           # Shared widgets: SkillCard, DrillCard, ProgressRing, AppButton
├── domain/
│   ├── entities/          # Pure Dart models: Skill, ProgressionStage, Drill, Hurdle, ...
│   └── repositories/      # Abstract interfaces (swap for Firebase here later)
├── data/
│   ├── seed/              # Handstand content: 8 stages, 15+ drills, 5 hurdles
│   ├── models/            # JSON-serialisable data models
│   ├── datasources/local/ # SharedPreferences read/write
│   └── repositories/      # Concrete implementations of domain interfaces
└── presentation/
    ├── providers/          # Riverpod: skills, progress, practice session state
    └── screens/
        ├── onboarding/
        ├── home/
        ├── skills/
        ├── skill_detail/
        ├── progression/
        ├── hurdles/
        ├── daily_practice/
        └── progress_tracking/
```

---

## Adding Firebase later

The repository interfaces in `lib/domain/repositories/` are the only contracts the app depends on.  
To add remote sync:

1. Add `firebase_core`, `cloud_firestore` to `pubspec.yaml`
2. Create `FirebaseSkillDatasource` and `FirebaseProgressDatasource` in `lib/data/datasources/remote/`
3. Create new repository implementations that call both local and remote datasources
4. Override the Riverpod providers in `main.dart` with the new implementations

No screens or domain logic need to change.

---

## Common issues

| Problem | Fix |
|---|---|
| `flutter: command not found` | Close and reopen the terminal after installing Flutter |
| `Android license status unknown` | Run `flutter doctor --android-licenses` and accept all |
| No devices listed | Start the emulator in Android Studio first, or check USB Debugging on your device |
| Gradle build fails | Make sure Android Studio completed its SDK setup wizard |
