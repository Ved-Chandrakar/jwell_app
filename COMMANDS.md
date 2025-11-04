# Flutter Commands Reference

## 🚀 Quick Commands

### First Time Setup
```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

### Development
```bash
# Run on specific device
flutter devices                    # List devices
flutter run -d <device-id>        # Run on specific device

# Hot reload (in terminal during run)
r                                  # Hot reload
R                                  # Hot restart
q                                  # Quit
```

### Clean & Rebuild
```bash
# Clean project
flutter clean

# Full clean rebuild
flutter clean && flutter pub get && flutter run
```

## 🔧 Build Commands

### Debug Builds
```bash
# Android APK (debug)
flutter build apk --debug

# Install on device
flutter install
```

### Release Builds
```bash
# Android APK (release)
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# Check APK size
flutter build apk --release --analyze-size
```

## 🧪 Testing & Analysis

### Code Quality
```bash
# Analyze code
flutter analyze

# Format code
flutter format lib/

# Check Flutter setup
flutter doctor
flutter doctor -v                 # Verbose
```

### Testing
```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📱 Device Management

### Emulator
```bash
# List emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator-id>

# List running devices
flutter devices
```

### Physical Device
```bash
# Connect device via USB
# Enable USB debugging on device
# Then:
flutter devices                   # Should show your device
flutter run                       # Will run on connected device
```

## 🔥 Firebase Commands

### Android SHA Fingerprints
```bash
# Debug fingerprint
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# Release fingerprint (if you have release keystore)
keytool -list -v -keystore /path/to/release.keystore -alias <your-alias>
```

## 📦 Dependency Management

### Update Dependencies
```bash
# Update all packages
flutter pub upgrade

# Update specific package
flutter pub upgrade <package-name>

# Get latest versions
flutter pub outdated
```

### Clean Dependencies
```bash
# Clear pub cache
flutter pub cache repair

# Remove unused dependencies
flutter pub deps

# Fix dependency issues
flutter clean
flutter pub get
```

## 🐛 Debugging

### Verbose Output
```bash
# Run with verbose logging
flutter run -v

# Build with verbose
flutter build apk -v
```

### Performance
```bash
# Profile mode (for performance testing)
flutter run --profile

# Release mode
flutter run --release
```

### Debugging Tools
```bash
# Open DevTools (during flutter run)
Press 'w' in terminal

# Or open manually
flutter pub global activate devtools
flutter pub global run devtools
```

## 📊 Project Info

### Information Commands
```bash
# Flutter version
flutter --version

# Dart version
dart --version

# List packages
flutter pub deps

# Project size
flutter build apk --analyze-size
```

## 🔧 Configuration

### SDK Management
```bash
# Update Flutter
flutter upgrade

# Switch Flutter channel
flutter channel stable
flutter channel beta
flutter channel dev

# Downgrade Flutter
flutter downgrade
```

## 🚨 Troubleshooting Commands

### Common Fixes
```bash
# Fix "flutter command not found"
export PATH="$PATH:/path/to/flutter/bin"

# Fix license issues
flutter doctor --android-licenses

# Fix Gradle issues
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Reset Everything
```bash
# Nuclear option - complete reset
flutter clean
rm -rf .dart_tool/
rm -rf build/
rm pubspec.lock
flutter pub cache repair
flutter pub get
```

## 📱 Platform-Specific

### Android
```bash
# Check Android setup
flutter doctor --android-licenses

# Build different formats
flutter build apk --split-per-abi     # Smaller APKs
flutter build apk --target-platform android-arm64
```

### Logging
```bash
# Android logs
flutter logs

# Or use adb
adb logcat
```

## 🎯 Useful Shortcuts (during flutter run)

```
r - Hot reload (apply code changes)
R - Hot restart (restart app)
h - List available commands
p - Toggle performance overlay
P - Toggle platform (Android/iOS modes)
o - Toggle platform override
w - Open DevTools
q - Quit
```

## 📝 Git Commands (for this project)

```bash
# Initial commit
git init
git add .
git commit -m "Initial commit: Complete jewel order app"

# Create repository on GitHub and push
git remote add origin <your-repo-url>
git push -u origin main
```

## 🔐 Keystore Management

### Create Release Keystore
```bash
# Create keystore
keytool -genkey -v -keystore ~/jewel-order-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias jewel-order

# List keystore info
keytool -list -v -keystore ~/jewel-order-key.jks -alias jewel-order
```

### Configure for Release (create android/key.properties)
```properties
storePassword=your_password
keyPassword=your_password
keyAlias=jewel-order
storeFile=/path/to/jewel-order-key.jks
```

## 🌐 Networking

### Check API
```bash
# Test FakeStore API
curl https://fakestoreapi.com/products/category/jewelery
```

## 💡 Pro Tips

### Speed Up Development
```bash
# Use --fast-start for quicker rebuilds
flutter run --fast-start

# Use --no-sound-null-safety if needed
flutter run --no-sound-null-safety
```

### Specific Builds
```bash
# Build for specific architecture
flutter build apk --target-platform android-arm64

# Build with custom build name
flutter build apk --build-name=1.0.0 --build-number=1
```

## 📚 Help Commands

```bash
# General help
flutter help

# Help for specific command
flutter build --help
flutter run --help
flutter test --help
```

## 🎯 Common Workflows

### Complete Development Workflow
```bash
# 1. Start fresh
flutter clean
flutter pub get

# 2. Check setup
flutter doctor

# 3. Start emulator (if needed)
flutter emulators --launch <emulator>

# 4. Run app
flutter run

# 5. Make changes and hot reload (press 'r')
# 6. Debug with DevTools (press 'w')
```

### Pre-Release Checklist
```bash
# 1. Analyze code
flutter analyze

# 2. Format code
flutter format lib/

# 3. Run tests
flutter test

# 4. Build release
flutter build appbundle --release

# 5. Check size
flutter build apk --release --analyze-size
```

## 🔗 Quick Links

- Flutter Docs: https://docs.flutter.dev
- Pub.dev: https://pub.dev
- Flutter DevTools: https://docs.flutter.dev/tools/devtools

---

**Keep this file handy for quick reference!** 📌
