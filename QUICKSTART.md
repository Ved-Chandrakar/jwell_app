# Quick Start Guide - Jewel Order App

This guide will help you get the app running quickly.

## Prerequisites Checklist

- [ ] Flutter SDK installed (3.0.0+)
- [ ] Android Studio or VS Code with Flutter extension
- [ ] Git installed
- [ ] Active internet connection

## Quick Setup (5 minutes)

### Step 1: Get Dependencies (1 min)

```bash
cd jewel_order_app
flutter pub get
```

### Step 2: Firebase Setup (3 mins)

#### Option A: Quick Test (Skip Firebase temporarily)
The app will build but authentication won't work. Good for seeing the UI.

#### Option B: Full Setup (Recommended)

1. Go to https://console.firebase.google.com/
2. Create new project: "jewel-order-app"
3. Add Android app:
   - Package: `com.example.jewel_order_app`
   - Download `google-services.json`
   - Place in `android/app/`

4. Enable Google Sign-In:
   - Authentication → Sign-in method → Google → Enable

5. Add SHA-1:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
   - Copy SHA-1
   - Project Settings → Your apps → Add fingerprint

### Step 3: Run (1 min)

```bash
flutter run
```

## First Time Running

### Expected Behavior

1. **Splash Screen**: Shows for 3 seconds with jewel icon
2. **Login Screen**: Beautiful gradient with Google Sign-In button
3. **Sign In**: Click Google button (needs Firebase setup)
4. **Home Screen**: 
   - Sales bar chart at top
   - Featured products (horizontal)
   - All products (grid)
   - Cart icon with badge
5. **Browse**: Click any product to see details
6. **Add to Cart**: Use increment/decrement, then add
7. **Cart**: Click cart icon, adjust quantities
8. **Checkout**: Mock payment (80% success rate)
9. **Profile**: View/update profile, logout

## Testing Without Firebase

To test the UI without Firebase:

1. Comment out Firebase initialization in `main.dart`:
   ```dart
   // await Firebase.initializeApp();
   ```

2. Update `SplashController` to skip auth check:
   ```dart
   Get.offAllNamed(AppRoutes.HOME);  // Always go to home
   ```

3. The app will show products but authentication won't work

## Common Commands

```bash
# Clean build
flutter clean
flutter pub get

# Run on specific device
flutter devices
flutter run -d <device-id>

# Build APK
flutter build apk

# Check for issues
flutter doctor
```

## Troubleshooting

### Issue: "Target of URI doesn't exist"
**Solution**: Run `flutter pub get`

### Issue: "No Firebase App"
**Solution**: 
- Check `google-services.json` is in `android/app/`
- Verify package name matches

### Issue: "Google Sign-In Failed"
**Solution**:
- Verify SHA-1 is added to Firebase
- Check Google Sign-In is enabled
- Ensure internet connection

### Issue: "Build Failed"
**Solution**:
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

## Default Test Data

- **Sales Data**: 6 dummy products with random sales counts
- **Products**: Fetched from FakeStore API (jewellery category)
- **Payment**: Mock implementation (80% success rate)
- **Tax Rate**: 10%

## What Works Out of the Box

✅ Product browsing
✅ Cart management
✅ Sales chart
✅ Mock payment
✅ UI/UX

## What Needs Firebase

⚠️ Google Sign-In
⚠️ User profile data
⚠️ Profile photo sync

## Next Steps

1. ✅ Run the app
2. ✅ Browse products
3. ✅ Test cart functionality
4. ✅ Try checkout flow
5. 🔧 Set up Firebase for full features
6. 🔧 Add real payment gateway (Stripe)
7. 🚀 Deploy to Play Store

## Development Tips

- Hot reload works: Press `r` in terminal
- Hot restart: Press `R` in terminal
- Open DevTools: Press `w` in terminal
- State is managed by GetX (check controllers)
- Products cached in memory (reload app for fresh data)

## File Structure at a Glance

```
lib/
├── main.dart                    # Start here
├── app/
│   ├── controllers/            # GetX controllers
│   ├── data/
│   │   ├── models/            # Data models
│   │   └── services/          # API & Auth services
│   ├── modules/               # UI screens
│   │   ├── splash/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── details/
│   │   ├── cart/
│   │   ├── payment/
│   │   └── profile/
│   └── routes/                # Navigation
```

## Support

- Check README.md for detailed docs
- Check FIREBASE_SETUP.md for Firebase steps
- Review code comments for implementation details

---

**Ready to start?** Run `flutter pub get` and then `flutter run`! 🚀
