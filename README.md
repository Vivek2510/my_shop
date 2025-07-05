# 🛍️ My Shop – Flutter Demo App

A simple Flutter demo app to showcase:
- 📦 Product listing from API  
- 🔍 Real-time search with suggestions  
- 🌗 Light/Dark Theme switcher  
- 💾 Local storage for recent search history  

---

## ✨ Features

| Feature            | Description                                                |
|--------------------|------------------------------------------------------------|
| 📦 Product Listing | Displays a list of products fetched from an API            |
| 🔍 Search          | Search with previous search suggestions stored locally     |
| 🌗 Theme Support   | Light and Dark mode toggle using `Bloc` pattern            |
| 💾 Local Storage   | Saves recent search terms for suggestions                  |

---

## 📸 Preview

### 🎥 Demo Video  
[![Watch the demo](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://www.youtube.com/watch?v=YOUR_VIDEO_ID)

### 🖼️ Screenshots

| Home Screen                          | Search Suggestion                    |
|-------------------------------------|--------------------------------------|
| ![Home](assets/images/home_screen.png) | ![Search](assets/images/search_suggestion.png) |

---

## 🧑‍💻 Getting Started

### ✅ Prerequisites

- Flutter SDK ≥ 3.10  
- Dart ≥ 3.x  
- Android Studio or Xcode  
- iOS device/simulator (for iOS)  

---

### 🛠️ Setup Steps

#### 1. Clone the repository

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

#### 2.  Install dependencies

```bash
flutter pub get
```

▶️ Run the App
✅ Android
```bash
flutter run
```

🍎 iOS Setup & Run
iOS build requires a macOS system with Xcode installed

1. Install CocoaPods dependencies
```bash
cd ios
pod install
cd ..
```

2. Open the iOS project in Xcode

open ios/Runner.xcworkspace


3. Configure Signing
Select the Runner project

Go to Signing & Capabilities

Choose your Apple Developer Team

Enable Automatically manage signing

4. Run on iOS Device or Simulator
From Xcode or via terminal:
```bash
flutter run
```
