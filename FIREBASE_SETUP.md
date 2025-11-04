# Firebase Configuration Instructions

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project" or select existing project
3. Follow the setup wizard

## Step 2: Add Android App

1. In Firebase Console, click "Add app" and select Android
2. Enter package name: `com.example.jewel_order_app`
3. (Optional) Enter app nickname: "Jewel Order App"
4. Get SHA-1 fingerprint:
   ```bash
   # For debug build
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
5. Click "Register app"

## Step 3: Download Configuration

1. Download `google-services.json`
2. Place it in `android/app/` directory
3. **Important**: Delete or rename `google-services.json.example`

## Step 4: Enable Authentication

1. In Firebase Console, go to "Authentication"
2. Click "Get Started"
3. Go to "Sign-in method" tab
4. Enable "Google" provider
5. Add support email
6. Save

## Step 5: Add SHA Fingerprints

1. In Firebase Console, go to Project Settings
2. Scroll to "Your apps" section
3. Click on your Android app
4. Add SHA-1 and SHA-256 fingerprints
5. Click "Save"

## Step 6: Google Sign-In Setup

1. The OAuth client will be automatically created by Firebase
2. Verify in [Google Cloud Console](https://console.cloud.google.com/)
3. Ensure the OAuth client has the correct package name and SHA-1

## Step 7: Test

1. Run the app
2. Try signing in with Google
3. Check Firebase Console > Authentication > Users to see if user was created

## Troubleshooting

- **Sign-in fails**: Verify SHA-1 fingerprints are correct
- **Package name mismatch**: Ensure package name is `com.example.jewel_order_app` everywhere
- **Google services error**: Verify `google-services.json` is in the correct location

## iOS Setup (Optional)

1. In Firebase Console, add iOS app
2. Enter bundle ID: `com.example.jewelOrderApp`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory
5. Follow similar authentication setup steps
