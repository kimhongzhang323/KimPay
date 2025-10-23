import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import '../models/linked_account_models.dart';
import 'account_authorization_screen.dart';

class AddAccountMethodScreen extends StatelessWidget {
  final AvailableAccount account;

  const AddAccountMethodScreen({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    // Map payment method logos
    String? logoAsset;
    switch (account.accountType.toLowerCase()) {
      case 'touchngo':
        logoAsset = 'assets/images/touchngo.png';
        break;
      case 'boost':
        logoAsset = 'assets/images/boost.png';
        break;
      case 'alipay':
        logoAsset = 'assets/images/alipay.png';
        break;
      case 'wechat':
        logoAsset = 'assets/images/wechatpay.png';
        break;
      case 'paypal':
        logoAsset = 'assets/images/paypal.png';
        break;
      case 'grab':
        logoAsset = 'assets/images/grab.png';
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add Account'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Account Logo and Name
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(color: AppColors.divider, width: 0.5),
                ),
                padding: const EdgeInsets.all(16),
                child: logoAsset != null
                    ? Image.asset(
                        logoAsset,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.account_balance_wallet,
                            color: AppColors.primaryBlue,
                            size: 40,
                          );
                        },
                      )
                    : const Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.primaryBlue,
                        size: 40,
                      ),
              ),
              const SizedBox(height: 24),
              Text(
                account.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                account.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              
              // Connection Methods Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Connection Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Method 1: Jump to App
              _MethodCard(
                icon: Icons.launch,
                iconColor: AppColors.primaryBlue,
                title: 'Quick Connect',
                subtitle: 'Jump to ${account.name} app to authorize',
                badge: 'Recommended',
                badgeColor: AppColors.accentGreen,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountAuthorizationScreen(
                        account: account,
                        isManual: false,
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              // Method 2: Manual Login
              _MethodCard(
                icon: Icons.login,
                iconColor: AppColors.accentPurple,
                title: 'Manual Login',
                subtitle: 'Enter credentials manually',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountAuthorizationScreen(
                        account: account,
                        isManual: true,
                      ),
                    ),
                  );
                },
              ),
              
              const Spacer(),
              
              // Security Notice
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: AppColors.primaryBlue,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your credentials are encrypted and stored securely',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback onTap;

  const _MethodCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.badge,
    this.badgeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor ?? AppColors.primaryBlue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
