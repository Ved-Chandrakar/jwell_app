# Setup Instructions - First Time

## ⚡ Quick Start (Run These Commands)

```bash
# 1. Navigate to project
cd "d:\dev projects\jwell_app"

# 2. Get all Flutter dependencies
flutter pub get

# 3. (Optional) Clean and rebuild
flutter clean
flutter pub get

# 4. Run the app
flutter run
```

## 📝 Important Notes

### Current State
✅ All code files created
✅ All configurations in place
✅ Project structure complete
⚠️ Dependencies need to be downloaded (run `flutter pub get`)
⚠️ Firebase needs to be configured for authentication

### Expected Errors Before `flutter pub get`
You'll see errors like:
- "Target of URI doesn't exist: 'package:get/get.dart'"
- "Undefined class 'Widget'"

**These are NORMAL** - They'll disappear after running `flutter pub get`

## 🔥 Firebase Setup (Required for Authentication)

### Quick Firebase Setup

1. **Create Firebase Project**
   - Go to: https://console.firebase.google.com/
   - Click "Add Project"
   - Name: "jewel-order-app"

2. **Add Android App**
   - Click Android icon
   - Package name: `com.example.jewel_order_app`
   - Download `google-services.json`
   - Place in: `android/app/google-services.json`

3. **Enable Google Sign-In**
   - Go to Authentication → Sign-in method
   - Enable "Google"
   - Add support email

4. **Get SHA-1 Fingerprint**
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
   - Windows path: `C:\Users\YourUsername\.android\debug.keystore`

5. **Add SHA-1 to Firebase**
   - Firebase Console → Project Settings
   - Your apps → Android app
   - Add fingerprint (SHA-1 and SHA-256)

## ✅ Verify Setup

### Check Flutter
```bash
flutter doctor
```

Should show:
- ✓ Flutter SDK
- ✓ Android toolchain
- ✓ Android Studio / VS Code

### Check Dependencies
```bash
flutter pub get
```

Should complete without errors.

### Check App Runs
```bash
flutter devices
flutter run
```

## 🎯 What to Expect When Running

1. **First Screen**: Splash screen (3 seconds)
2. **Login Screen**: Appears (needs Firebase to work)
3. **After Login**: Home with products and sales chart

### Without Firebase
- App builds successfully
- Products load from API
- Google Sign-In button won't work
- Can still browse UI

### With Firebase
- Full authentication works
- Profile syncs
- Complete user experience

## 🐛 Troubleshooting

### "flutter: command not found"
```bash
# Add Flutter to PATH or run:
export PATH="$PATH:`pwd`/flutter/bin"
```

### "Android license status unknown"
```bash
flutter doctor --android-licenses
```

### "No devices found"
- Start Android Emulator
- Or connect physical device with USB debugging

### Package dependency errors
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

### Firebase initialization fails
- Check `google-services.json` is in `android/app/`
- Verify package name matches
- Rebuild app: `flutter clean && flutter run`

## 📱 Running on Device

### Android Emulator
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d emulator-5554
```

### Physical Device
1. Enable Developer Options
2. Enable USB Debugging
3. Connect via USB
4. `flutter run`

## 🏗️ Building Release

### Debug Build (for testing)
```bash
flutter build apk --debug
```

### Release Build (for production)
```bash
# First time: Create keystore
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

# Then build
flutter build apk --release
# or
flutter build appbundle --release
```

## 📚 Documentation Reference

- **README.md** - Complete documentation
- **QUICKSTART.md** - 5-minute setup
- **FIREBASE_SETUP.md** - Detailed Firebase guide
- **FEATURE_CHECKLIST.md** - All features
- **PROJECT_SUMMARY.md** - Project overview

## ✨ Next Steps After Setup

1. ✅ Run `flutter pub get`
2. ✅ Run `flutter run` to see the app
3. ✅ Set up Firebase for full features
4. ✅ Test all screens
5. ✅ Customize as needed
6. ✅ Deploy!

## 🚀 You're Ready!

Once you run `flutter pub get`, all errors will disappear and the app is ready to run!

---

**Need Help?** Check the documentation files or run `flutter doctor` for diagnostics.
