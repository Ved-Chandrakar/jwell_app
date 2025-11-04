import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controllers/auth_controller.dart';
import '../../data/services/auth_service.dart';
import '../../core/theme/app_theme.dart';

class ProfileView extends GetView<AuthController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: controller.getUserInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final userInfo = snapshot.data!;
          final userName = userInfo['name'] ?? 'User';
          final userEmail = userInfo['email'] ?? '';
          final userPhoto = userInfo['photo'] ?? '';

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                
                // Profile Picture
                _ProfilePictureWidget(
                  photoUrl: userPhoto,
                  userName: userName,
                ),
                
                const SizedBox(height: 24),
                
                // User Name
                Text(
                  userName,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                // User Email
                Text(
                  userEmail,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),
                
                // Profile Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildProfileOption(
                        context,
                        icon: Icons.photo_camera,
                        title: 'Change Profile Photo',
                        subtitle: 'Update your profile picture',
                        onTap: () => _changeProfilePhoto(context),
                      ),
                      const Divider(),
                      
                      _buildProfileOption(
                        context,
                        icon: Icons.shopping_bag,
                        title: 'Order History',
                        subtitle: 'View your past orders',
                        onTap: () {
                          Get.snackbar(
                            'Coming Soon',
                            'Order history feature will be available soon',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      const Divider(),
                      
                      _buildProfileOption(
                        context,
                        icon: Icons.favorite,
                        title: 'Wishlist',
                        subtitle: 'View your saved items',
                        onTap: () {
                          Get.snackbar(
                            'Coming Soon',
                            'Wishlist feature will be available soon',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      const Divider(),
                      
                      _buildProfileOption(
                        context,
                        icon: Icons.settings,
                        title: 'Settings',
                        subtitle: 'App preferences and settings',
                        onTap: () {
                          Get.snackbar(
                            'Coming Soon',
                            'Settings will be available soon',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      const Divider(),
                      
                      const SizedBox(height: 32),
                      
                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _showLogoutDialog(context),
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.errorColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Future<void> _changeProfilePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    await _saveProfilePhoto(image.path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    await _saveProfilePhoto(image.path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveProfilePhoto(String imagePath) async {
    final authService = Get.find<AuthService>();
    await authService.updateLocalProfilePhoto(imagePath);
    
    Get.snackbar(
      'Success',
      'Profile photo updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // Reload the page to show new photo
    Get.forceAppUpdate();
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              controller.signOut();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.errorColor,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _ProfilePictureWidget extends StatefulWidget {
  final String photoUrl;
  final String userName;

  const _ProfilePictureWidget({
    required this.photoUrl,
    required this.userName,
  });

  @override
  State<_ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<_ProfilePictureWidget> {
  String? localPhotoPath;

  @override
  void initState() {
    super.initState();
    _loadLocalPhoto();
  }

  Future<void> _loadLocalPhoto() async {
    final authService = Get.find<AuthService>();
    final path = await authService.getLocalProfilePhoto();
    if (path != null && mounted) {
      setState(() {
        localPhotoPath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.primaryColor,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: _buildProfileImage(),
      ),
    );
  }

  Widget _buildProfileImage() {
    // Priority: Local photo > Network photo > Placeholder
    if (localPhotoPath != null && File(localPhotoPath!).existsSync()) {
      return Image.file(
        File(localPhotoPath!),
        fit: BoxFit.cover,
      );
    } else if (widget.photoUrl.isNotEmpty) {
      return Image.network(
        widget.photoUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.primaryColor,
      child: Center(
        child: Text(
          widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'U',
          style: const TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
