# Brownfield Calculator App

A monorepo demonstrating React Native brownfield integration with native iOS (Swift/UIKit) and Android (Kotlin/XML) calculator apps.

## Project Structure

```
brownfield/
├── apps/
│   ├── ios/Calculator/          # Native iOS Calculator (Swift/UIKit)
│   └── android/Calculator/      # Native Android Calculator (Kotlin/XML)
├── packages/
│   └── react-native-module/     # React Native "Info" screen
└── package.json                 # Root monorepo config
```

## Prerequisites

- Node.js >= 18.0.0
- Yarn
- Xcode 15+ (for iOS)
- Android Studio (for Android)
- CocoaPods

## Getting Started

### Install Dependencies

```bash
yarn install
```

### iOS

1. Open `apps/ios/Calculator/Calculator.xcworkspace` in Xcode
2. Build and run on simulator or device

### Android

1. Open `apps/android/Calculator` in Android Studio
2. Build and run on emulator or device

### React Native Module (Standalone)

```bash
yarn rn:start
```

## Features

- **Calculator**: Basic arithmetic operations (+, -, ×, ÷)
- **Info Screen**: React Native powered info page accessible from native apps
- **Brownfield Integration**: Seamless native to React Native navigation

## Architecture

The project uses `@callstack/react-native-brownfield` for integrating React Native into existing native apps:

- **iOS**: XCFramework built from React Native module
- **Android**: AAR library published to mavenLocal

## License

MIT
