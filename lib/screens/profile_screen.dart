import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import 'settings_detail_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Light background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildProfileInfo(),
              const SizedBox(height: 32),
              _buildStatsRow(),
              const SizedBox(height: 32),
              _buildSettingsSection(context),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.settings, size: 20, color: Colors.black),
            onPressed: () {
               // Navigate to settings detail with required parameters
               Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsDetailScreen(
                 title: 'Settings',
                 icon: Icons.settings,
                 settingType: 'general', // Or appropriate default
               )));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Kimmy',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '@kimmy_ux',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem('Income', '\$8,500'),
        _buildStatItem('Transactions', '45'),
        _buildStatItem('Expense', '\$2,100'),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          _buildSettingsTile(Icons.person_outline, 'Personal Information', () {}),
          const Divider(height: 32, thickness: 1, color: Color(0xFFF5F6FA)),
          _buildSettingsTile(Icons.security, 'Login & Security', () {}),
          const Divider(height: 32, thickness: 1, color: Color(0xFFF5F6FA)),
          _buildSettingsTile(Icons.notifications_outlined, 'Notification', () {}),
          const Divider(height: 32, thickness: 1, color: Color(0xFFF5F6FA)),
          _buildSettingsTile(Icons.help_outline, 'Help & Support', () {}),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F6FA),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
