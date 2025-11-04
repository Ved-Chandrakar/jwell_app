# Jewel Order App

A complete Flutter e-commerce application for ordering luxury jewellery, featuring Firebase authentication, Google Sign-In, real-time sales tracking, and a beautiful, modern UI.

## Features

- 🔐 **Authentication**: Firebase Authentication with Google Sign-In
- 💎 **Product Catalog**: Browse luxury jewellery from FakeStore API
- 📊 **Sales Analytics**: Real-time sales tracking with interactive bar charts
- 🛒 **Shopping Cart**: Full cart management with quantity controls
- 💳 **Payment Integration**: Mock payment gateway (ready for Stripe/Razorpay)
- 👤 **User Profile**: Profile management with photo upload
- 🎨 **Modern UI**: Clean, attractive design with smooth animations
- 📱 **Responsive**: Works on all screen sizes

## Tech Stack

- **Framework**: Flutter
- **State Management**: GetX
- **Backend**: Firebase (Auth)
- **API**: FakeStore API for product data
- **Charts**: FL Chart for sales visualization
- **Payment**: Stripe (Test Mode)
- **Local Storage**: SharedPreferences

## Screenshots

[Add screenshots here]

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase Account
- Google Cloud Console Account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd jewel_order_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   a. Create a new project in [Firebase Console](https://console.firebase.google.com/)
   
   b. Enable Authentication:
      - Go to Authentication > Sign-in method
      - Enable Google Sign-In
      - Add your SHA-1 and SHA-256 fingerprints
   
   c. Download configuration files:
      - **Android**: Download `google-services.json` and place it in `android/app/`
      - **iOS**: Download `GoogleService-Info.plist` and place it in `ios/Runner/`
   
   d. Get SHA-1 fingerprint:
      ```bash
      # For debug
      keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
      
      # For release (create keystore first)
      keytool -list -v -keystore path/to/your/keystore -alias your-alias
      ```

4. **Google Sign-In Setup**

   a. Go to [Google Cloud Console](https://console.cloud.google.com/)
   
   b. Enable Google Sign-In API
   
   c. Create OAuth 2.0 credentials:
      - Application type: Android/iOS
      - Add your package name: `com.example.jewel_order_app`
      - Add SHA-1 fingerprint
   
   d. Download and configure the credentials

5. **Stripe Setup (Optional - for production)**

   a. Create account at [Stripe](https://stripe.com/)
   
   b. Get your publishable key from Dashboard
   
   c. Update `main.dart`:
      ```dart
      Stripe.publishableKey = 'pk_test_your_actual_publishable_key';
      ```
   
   d. Note: Current implementation uses mock payment. For production:
      - Implement backend API for payment intent creation
      - Update PaymentService with actual Stripe integration
      - Follow Stripe Flutter SDK documentation

### Configuration Files

1. **Create `android/app/google-services.json`** (from Firebase Console)

2. **Create `ios/Runner/GoogleService-Info.plist`** (from Firebase Console)

3. **Update `android/app/build.gradle`**:
   ```gradle
   // Already configured, but verify:
   - applicationId matches Firebase project
   - minSdkVersion is at least 21
   ```

4. **Update `AndroidManifest.xml`**:
   ```xml
   <!-- Already configured for internet permission -->
   ```

### Assets

Place the following assets (optional):
- `assets/images/google_logo.png` - Google logo for sign-in button

## Running the App

1. **Start an emulator or connect a device**

2. **Run the app**
   ```bash
   flutter run
   ```

3. **Build for release**
   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   ```

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── app/
│   ├── core/
│   │   └── theme/
│   │       └── app_theme.dart         # App theme configuration
│   ├── data/
│   │   ├── models/
│   │   │   ├── product_model.dart     # Product data model
│   │   │   └── cart_item_model.dart   # Cart item model
│   │   └── services/
│   │       ├── auth_service.dart      # Firebase auth service
│   │       └── api_service.dart       # API service for products
│   ├── controllers/
│   │   ├── auth_controller.dart       # Authentication controller
│   │   ├── product_controller.dart    # Product management
│   │   ├── cart_controller.dart       # Cart management
│   │   └── sales_controller.dart      # Sales tracking
│   ├── modules/
│   │   ├── splash/                    # Splash screen
│   │   ├── auth/                      # Login screen
│   │   ├── home/                      # Home with products & chart
│   │   ├── details/                   # Product details
│   │   ├── cart/                      # Shopping cart
│   │   ├── payment/                   # Payment service
│   │   └── profile/                   # User profile
│   └── routes/
│       ├── app_routes.dart            # Route constants
│       └── app_pages.dart             # Route configuration
```

## Key Features Implementation

### 1. Authentication
- Firebase Authentication with Google Sign-In
- Automatic session management
- User profile data storage

### 2. Product Catalog
- Fetches jewellery from FakeStore API
- Featured products horizontal scroll
- All products grid view
- Error handling and retry mechanism

### 3. Sales Graph
- Bar chart showing top 6 products
- Real-time updates after purchases
- Persistent data using SharedPreferences

### 4. Shopping Cart
- Add/remove products
- Quantity management
- Real-time total calculation
- Tax calculation (10%)
- Cart badge on home screen

### 5. Product Details
- Full product information
- Image preview
- Quantity selector
- Add to cart functionality

### 6. Payment
- Mock payment gateway
- Success/failure handling
- Order confirmation dialog
- Cart clearing on success
- Sales data update

### 7. Profile
- User information display
- Profile photo upload
- Google profile photo display
- Logout functionality

## API Reference

### FakeStore API
- **Base URL**: `https://fakestoreapi.com`
- **Endpoint**: `/products/category/jewelery`
- **Method**: GET
- **Response**: Array of product objects

## State Management

Uses **GetX** for:
- Reactive state management
- Dependency injection
- Route management
- Snackbar notifications

## Local Storage

Uses **SharedPreferences** for:
- Sales data persistence
- User information caching
- Profile photo path storage

## Troubleshooting

### Common Issues

1. **Google Sign-In fails**
   - Verify SHA-1/SHA-256 fingerprints in Firebase
   - Check package name matches in all configs
   - Ensure Google Sign-In is enabled in Firebase Console

2. **Build fails**
   - Run `flutter clean`
   - Run `flutter pub get`
   - Check all configuration files are in place

3. **API errors**
   - Check internet connection
   - Verify FakeStore API is accessible
   - Check error messages in console

4. **Firebase errors**
   - Ensure `google-services.json` is in correct location
   - Verify Firebase project is active
   - Check Firebase dependencies versions

## Future Enhancements

- [ ] Real Stripe/Razorpay payment integration
- [ ] Order history tracking
- [ ] Wishlist functionality
- [ ] Product search and filters
- [ ] Push notifications
- [ ] Multiple address management
- [ ] Product reviews and ratings
- [ ] Dark mode support

## Testing

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## Building for Production

### Android

1. **Create keystore**:
   ```bash
   keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
   ```

2. **Create `android/key.properties`**:
   ```
   storePassword=<password>
   keyPassword=<password>
   keyAlias=key
   storeFile=<path-to-key.jks>
   ```

3. **Build**:
   ```bash
   flutter build appbundle --release
   ```

### iOS

1. **Configure in Xcode**
2. **Build**:
   ```bash
   flutter build ios --release
   ```

## License

This project is for educational purposes.

## Support

For issues and questions:
- Create an issue in the repository
- Check existing documentation

## Credits

- Product data: [FakeStore API](https://fakestoreapi.com/)
- Icons: Flutter Material Icons
- Charts: FL Chart package

---

Built with ❤️ using Flutter
#   j w e l l _ a p p  
 