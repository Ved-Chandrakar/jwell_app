import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  
  Rx<User?> firebaseUser = Rx<User?>(null);
  
  User? get user => firebaseUser.value;
  bool get isAuthenticated => user != null;

  Future<AuthService> init() async {
    // Listen to auth state changes
    firebaseUser.bindStream(_auth.authStateChanges());
    return this;
  }

  /// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // Save user info to local storage
      await _saveUserInfo(userCredential.user);
      
      return userCredential;
    } catch (e) {
      Get.snackbar(
        'Sign In Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  /// Save user information to SharedPreferences
  Future<void> _saveUserInfo(User? user) async {
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', user.displayName ?? '');
      await prefs.setString('user_email', user.email ?? '');
      await prefs.setString('user_photo', user.photoURL ?? '');
      await prefs.setString('user_id', user.uid);
    }
  }

  /// Get saved user info from SharedPreferences
  Future<Map<String, String>> getSavedUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('user_name') ?? '',
      'email': prefs.getString('user_email') ?? '',
      'photo': prefs.getString('user_photo') ?? '',
      'id': prefs.getString('user_id') ?? '',
    };
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      
      // Clear saved user info
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_name');
      await prefs.remove('user_email');
      await prefs.remove('user_photo');
      await prefs.remove('user_id');
      await prefs.remove('local_profile_photo');
      
      Get.snackbar(
        'Success',
        'Signed out successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Sign Out Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Update local profile photo path
  Future<void> updateLocalProfilePhoto(String photoPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('local_profile_photo', photoPath);
  }

  /// Get local profile photo path
  Future<String?> getLocalProfilePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('local_profile_photo');
  }
}
