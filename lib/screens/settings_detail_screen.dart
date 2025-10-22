import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';

class SettingsDetailScreen extends StatefulWidget {
  final String title;
  final IconData icon;
  final String settingType;

  const SettingsDetailScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.settingType,
  });

  @override
  State<SettingsDetailScreen> createState() => _SettingsDetailScreenState();
}

class _SettingsDetailScreenState extends State<SettingsDetailScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = false;
  bool _aiSuggestionsEnabled = true;
  bool _spendingAlerts = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 24, 24),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent() {
    switch (widget.settingType) {
      case 'personal_info':
        return _buildPersonalInfo();
      case 'kyc':
        return _buildKYC();
      case 'currency':
        return _buildCurrencySettings();
      case 'password':
        return _buildPasswordSettings();
      case 'biometric':
        return _buildBiometricSettings();
      case 'two_factor':
        return _buildTwoFactorSettings();
      case 'notifications':
        return _buildNotificationSettings();
      case 'language':
        return _buildLanguageSettings();
      case 'ai_preferences':
        return _buildAIPreferences();
      case 'help':
        return _buildHelpCenter();
      case 'privacy':
        return _buildPrivacyPolicy();
      case 'terms':
        return _buildTermsOfService();
      case 'about':
        return _buildAbout();
      default:
        return [const Text('Coming soon...')];
    }
  }

  List<Widget> _buildPersonalInfo() {
    return [
      _buildInfoCard(
        'Full Name',
        'Kim Hong Zhang',
        Icons.person,
        () => _showEditDialog('Full Name', 'Kim Hong Zhang'),
      ),
      const SizedBox(height: 12),
      _buildInfoCard(
        'Email',
        'kimhong@kimpay.com',
        Icons.email,
        () => _showEditDialog('Email', 'kimhong@kimpay.com'),
      ),
      const SizedBox(height: 12),
      _buildInfoCard(
        'Phone',
        '+60 12-345 6789',
        Icons.phone,
        () => _showEditDialog('Phone', '+60 12-345 6789'),
      ),
      const SizedBox(height: 12),
      _buildInfoCard(
        'Date of Birth',
        'January 15, 2000',
        Icons.cake,
        () {},
      ),
      const SizedBox(height: 12),
      _buildInfoCard(
        'Address',
        'Kuala Lumpur, Malaysia',
        Icons.location_on,
        () => _showEditDialog('Address', 'Kuala Lumpur, Malaysia'),
      ),
      const SizedBox(height: 24),
      const Text(
        'Identity Verification',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 12),
      _buildInfoCard(
        'IC Number',
        '900115-10-5678',
        Icons.credit_card,
        () => _showEditDialog('IC Number', '900115-10-5678'),
      ),
      const SizedBox(height: 12),
      _buildInfoCard(
        'Passport Number',
        'A12345678',
        Icons.flight,
        () => _showEditDialog('Passport Number', 'A12345678'),
      ),
      const SizedBox(height: 12),
      GestureDetector(
        onTap: () => _showDocumentUpload('IC'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.upload_file, color: AppColors.primaryBlue, size: 20),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Upload IC Document',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      GestureDetector(
        onTap: () => _showDocumentUpload('Passport'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.upload_file, color: AppColors.primaryBlue, size: 20),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Upload Passport Document',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildKYC() {
    return [
      Container(
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
        child: Column(
          children: [
            const Icon(
              Icons.verified_user,
              color: AppColors.accentGreen,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Verified Account',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your identity has been verified',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildVerificationItem('Identity Document', true),
            _buildVerificationItem('Address Proof', true),
            _buildVerificationItem('Selfie Verification', true),
            _buildVerificationItem('Phone Verification', true),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildCurrencySettings() {
    final currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CNY', 'MYR', 'SGD', 'AUD'];
    return [
      Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Display Currency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...currencies.map((currency) => RadioListTile<String>(
                  value: currency,
                  groupValue: _selectedCurrency,
                  title: Text(_getCurrencyName(currency)),
                  activeColor: AppColors.primaryBlue,
                  onChanged: (value) {
                    setState(() {
                      _selectedCurrency = value!;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Currency changed to $value'),
                        backgroundColor: AppColors.accentGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildPasswordSettings() {
    return [
      _buildInfoCard(
        'Current Password',
        '••••••••',
        Icons.lock,
        () => _showPasswordDialog(),
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => _showPasswordDialog(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildBiometricSettings() {
    return [
      _buildSwitchTile(
        'Enable Biometric Login',
        'Use biometric authentication',
        Icons.fingerprint,
        _biometricEnabled,
        (value) => setState(() => _biometricEnabled = value),
      ),
      const SizedBox(height: 16),
      const Text(
        'Available Biometric Methods',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 12),
      _buildBiometricOption(
        'Fingerprint',
        'Touch sensor authentication',
        Icons.fingerprint,
        true,
      ),
      const SizedBox(height: 12),
      _buildBiometricOption(
        'Face Recognition',
        'Face unlock with 3D mapping',
        Icons.face,
        true,
      ),
      const SizedBox(height: 12),
      _buildBiometricOption(
        'Voice Recognition',
        'Sound identification verification',
        Icons.mic,
        false,
      ),
      const SizedBox(height: 12),
      _buildBiometricOption(
        'Virtual Signature',
        'Sign with your finger pattern',
        Icons.gesture,
        false,
      ),
      const SizedBox(height: 16),
      if (_biometricEnabled)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primaryBlue),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Multiple biometric methods provide enhanced security for your account.',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
    ];
  }

  List<Widget> _buildTwoFactorSettings() {
    return [
      _buildSwitchTile(
        'Two-Factor Authentication',
        'Add an extra layer of security',
        Icons.security,
        _twoFactorEnabled,
        (value) {
          setState(() => _twoFactorEnabled = value);
          if (value) {
            _showTwoFactorSetup();
          }
        },
      ),
      const SizedBox(height: 16),
      if (_twoFactorEnabled) ...[
        const Text(
          'Authentication Methods',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildTwoFactorOption(
          'Authenticator App',
          'Google Authenticator, Authy, etc.',
          Icons.phone_android,
          true,
        ),
        const SizedBox(height: 12),
        _buildTwoFactorOption(
          'SMS Verification',
          'Receive codes via SMS',
          Icons.sms,
          true,
        ),
        const SizedBox(height: 12),
        _buildTwoFactorOption(
          'Email Verification',
          'Receive codes via email',
          Icons.email,
          false,
        ),
        const SizedBox(height: 12),
        _buildTwoFactorOption(
          'Hardware Security Key',
          'YubiKey or similar devices',
          Icons.usb,
          false,
        ),
        const SizedBox(height: 12),
        _buildTwoFactorOption(
          'Backup Codes',
          'Emergency access codes',
          Icons.password,
          false,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.accentGreen),
                  SizedBox(width: 12),
                  Text(
                    '2FA is enabled',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Your account is protected with two-factor authentication',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    ];
  }

  List<Widget> _buildNotificationSettings() {
    return [
      _buildSwitchTile(
        'All Notifications',
        'Master control for all notifications',
        Icons.notifications,
        _notificationsEnabled,
        (value) => setState(() => _notificationsEnabled = value),
      ),
      const SizedBox(height: 16),
      _buildSwitchTile(
        'Email Notifications',
        'Receive updates via email',
        Icons.email,
        _emailNotifications,
        (value) => setState(() => _emailNotifications = value),
      ),
      const SizedBox(height: 16),
      _buildSwitchTile(
        'Push Notifications',
        'Receive push notifications on your device',
        Icons.phone_android,
        _pushNotifications,
        (value) => setState(() => _pushNotifications = value),
      ),
      const SizedBox(height: 16),
      _buildSwitchTile(
        'SMS Notifications',
        'Receive important updates via SMS',
        Icons.sms,
        _smsNotifications,
        (value) => setState(() => _smsNotifications = value),
      ),
    ];
  }

  List<Widget> _buildLanguageSettings() {
    final languages = [
      'English',
      '中文 (Chinese)',
      'Bahasa Melayu',
      '日本語 (Japanese)',
      'हिन्दी (Hindi)',
      'Español (Spanish)',
      'Français (French)',
      'Deutsch (German)',
      'Italiano (Italian)',
      'Português (Portuguese)',
      '한국어 (Korean)',
      'العربية (Arabic)',
      'ไทย (Thai)',
      'Tiếng Việt (Vietnamese)',
      'Indonesia',
    ];
    return [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accentGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.accentGreen.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accentGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.security, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Secure Translation',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'All languages are translated by our self-deployed GPT model to ensure your data security and privacy.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Language',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...languages.map((language) => RadioListTile<String>(
                  value: language,
                  groupValue: _selectedLanguage,
                  title: Text(language),
                  activeColor: AppColors.primaryBlue,
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Language changed to $value'),
                        backgroundColor: AppColors.accentGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildAIPreferences() {
    return [
      _buildSwitchTile(
        'AI Suggestions',
        'Get personalized spending insights',
        Icons.auto_awesome,
        _aiSuggestionsEnabled,
        (value) => setState(() => _aiSuggestionsEnabled = value),
      ),
      const SizedBox(height: 16),
      _buildSwitchTile(
        'Spending Alerts',
        'Receive alerts for unusual spending',
        Icons.warning_amber,
        _spendingAlerts,
        (value) => setState(() => _spendingAlerts = value),
      ),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.accentPurple.withOpacity(0.1),
              AppColors.primaryBlue.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.psychology, color: AppColors.accentPurple),
                SizedBox(width: 12),
                Text(
                  'About AI Features',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Our AI analyzes your spending patterns to provide personalized insights and help you make better financial decisions.',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildHelpCenter() {
    return [
      _buildHelpCard('How to add a card?', Icons.add_card),
      const SizedBox(height: 12),
      _buildHelpCard('How to transfer money?', Icons.send),
      const SizedBox(height: 12),
      _buildHelpCard('How to receive payments?', Icons.qr_code_scanner),
      const SizedBox(height: 12),
      _buildHelpCard('How to top up wallet?', Icons.account_balance_wallet),
      const SizedBox(height: 12),
      _buildHelpCard('Transaction fees explained', Icons.info),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Opening live chat...'),
              backgroundColor: AppColors.primaryBlue,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Contact Support',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildPrivacyPolicy() {
    return [
      _buildTextSection(
        'Privacy Policy',
        'Last updated: October 22, 2025\n\nKimPay values your privacy. This policy explains how we collect, use, and protect your personal information.\n\n1. Information Collection\nWe collect information you provide directly, such as when you create an account, make transactions, or contact support.\n\n2. Use of Information\nYour information is used to provide and improve our services, process transactions, and communicate with you.\n\n3. Data Security\nWe implement industry-standard security measures to protect your data from unauthorized access.\n\n4. Data Sharing\nWe do not sell your personal information. We may share data with service providers necessary for our operations.\n\n5. Your Rights\nYou have the right to access, correct, or delete your personal information at any time.',
      ),
    ];
  }

  List<Widget> _buildTermsOfService() {
    return [
      _buildTextSection(
        'Terms of Service',
        'Last updated: October 22, 2025\n\nWelcome to KimPay. By using our services, you agree to these terms.\n\n1. Account Terms\nYou must be at least 18 years old to use KimPay. You are responsible for maintaining the security of your account.\n\n2. Payment Terms\nAll transactions are final unless otherwise stated. We reserve the right to refuse service to anyone.\n\n3. Service Availability\nWe strive for 99.9% uptime but cannot guarantee uninterrupted service.\n\n4. Prohibited Activities\nYou may not use KimPay for illegal activities, fraud, or money laundering.\n\n5. Termination\nWe may suspend or terminate your account for violations of these terms.',
      ),
    ];
  }

  List<Widget> _buildAbout() {
    return [
      Center(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'KimPay',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
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
              child: const Column(
                children: [
                  Text(
                    'Your Digital Wallet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'KimPay is a modern digital wallet solution that helps you manage your finances, make payments, and track your spending with AI-powered insights.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '© 2025 KimPay. All rights reserved.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildInfoCard(String label, String value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryBlue, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit, size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationItem(String title, bool isVerified) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isVerified ? Icons.check_circle : Icons.cancel,
            color: isVerified ? AppColors.accentGreen : AppColors.accentRed,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(
              'This is a detailed explanation for: $title\n\nFor more help, please contact our support team.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryBlue, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSection(String title, String content) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrencyName(String code) {
    const names = {
      'USD': 'US Dollar',
      'EUR': 'Euro',
      'GBP': 'British Pound',
      'JPY': 'Japanese Yen',
      'CNY': 'Chinese Yuan',
      'MYR': 'Malaysian Ringgit',
      'SGD': 'Singapore Dollar',
      'AUD': 'Australian Dollar',
    };
    return '${names[code]} ($code)';
  }

  void _showEditDialog(String field, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: field,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$field updated successfully'),
                  backgroundColor: AppColors.accentGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Password updated successfully'),
                  backgroundColor: AppColors.accentGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showTwoFactorSetup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Setup 2FA'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Scan this QR code with your authenticator app:'),
            const SizedBox(height: 16),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.qr_code, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Or enter this code manually:'),
            const SizedBox(height: 8),
            const Text(
              'ABCD EFGH IJKL MNOP',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showDocumentUpload(String docType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upload $docType'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please upload a clear photo of your $docType'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Opening camera...'),
                    backgroundColor: AppColors.primaryBlue,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              label: const Text('Take Photo', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Opening gallery...'),
                    backgroundColor: AppColors.primaryBlue,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.photo_library),
              label: const Text('Choose from Gallery'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricOption(String title, String subtitle, IconData icon, bool isEnabled) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isEnabled ? AppColors.accentGreen : AppColors.textSecondary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isEnabled ? AppColors.accentGreen : AppColors.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isEnabled)
            const Icon(Icons.check_circle, color: AppColors.accentGreen, size: 20)
          else
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Setting up $title...'),
                    backgroundColor: AppColors.primaryBlue,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: const Text('Setup'),
            ),
        ],
      ),
    );
  }

  Widget _buildTwoFactorOption(String title, String subtitle, IconData icon, bool isEnabled) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isEnabled ? AppColors.accentGreen : AppColors.textSecondary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isEnabled ? AppColors.accentGreen : AppColors.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isEnabled)
            const Icon(Icons.check_circle, color: AppColors.accentGreen, size: 20)
          else
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Setting up $title...'),
                    backgroundColor: AppColors.primaryBlue,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: const Text('Setup'),
            ),
        ],
      ),
    );
  }
}
