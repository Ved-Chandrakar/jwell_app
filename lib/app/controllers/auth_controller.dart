import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/services/auth_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  Rx<User?> get firebaseUser => _authService.firebaseUser;
  
  @override
  void onReady() {
    super.onReady();
    // Listen to auth state changes and navigate accordingly
    ever(firebaseUser, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) {
    if (user == null) {
      Get.offAllNamed(AppRoutes.LOGIN);
    } else {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        Get.snackbar(
          'Success',
          'Welcome ${userCredential.user?.displayName ?? 'User'}!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign in: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _authService.signOut();
  }

  /// Get user info
  Future<Map<String, String>> getUserInfo() async {
    return await _authService.getSavedUserInfo();
  }
}
