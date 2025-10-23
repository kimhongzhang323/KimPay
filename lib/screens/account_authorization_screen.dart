import 'package:flutter/material.dart';
import 'dart:async';
import '../design_system/app_colors.dart';
import '../models/linked_account_models.dart';

class AccountAuthorizationScreen extends StatefulWidget {
  final AvailableAccount account;
  final bool isManual;

  const AccountAuthorizationScreen({
    super.key,
    required this.account,
    required this.isManual,
  });

  @override
  State<AccountAuthorizationScreen> createState() => _AccountAuthorizationScreenState();
}

class _AccountAuthorizationScreenState extends State<AccountAuthorizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isAuthorizationComplete = false;
  int _authStep = 0; // 0: initial, 1: authorizing, 2: success

  @override
  void initState() {
    super.initState();
    if (!widget.isManual) {
      // Auto-start authorization for quick connect
      Future.delayed(const Duration(milliseconds: 500), _simulateAppAuthorization);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _simulateAppAuthorization() async {
    setState(() {
      _authStep = 1;
    });

    // Simulate opening app and getting authorization
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _authStep = 2;
      _isAuthorizationComplete = true;
    });

    // Auto-redirect after success
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    _completeConnection();
  }

  Future<void> _handleManualLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _authStep = 1;
    });

    // Simulate API login
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _authStep = 2;
      _isAuthorizationComplete = true;
      _isLoading = false;
    });

    // Auto-redirect after success
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    _completeConnection();
  }

  void _completeConnection() {
    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('${widget.account.name} connected successfully!'),
          ],
        ),
        backgroundColor: AppColors.accentGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map payment method logos
    String? logoAsset;
    switch (widget.account.accountType.toLowerCase()) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.isManual ? 'Login' : 'Authorize'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: _authStep == 2
            ? _buildSuccessView(logoAsset)
            : widget.isManual
                ? _buildManualLoginView(logoAsset)
                : _buildQuickConnectView(logoAsset),
      ),
    );
  }

  Widget _buildQuickConnectView(String? logoAsset) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.divider, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: logoAsset != null
                ? Image.asset(
                    logoAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.primaryBlue,
                        size: 50,
                      );
                    },
                  )
                : const Icon(
                    Icons.account_balance_wallet,
                    color: AppColors.primaryBlue,
                    size: 50,
                  ),
          ),
          const SizedBox(height: 32),

          // Loading Animation
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Status Text
          Text(
            _authStep == 0 ? 'Opening ${widget.account.name}...' : 'Authorizing...',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _authStep == 0
                ? 'Please wait while we redirect you'
                : 'Grant permission to access your account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 48),

          // Mock Steps
          _AuthStep(
            number: 1,
            title: 'Verify Identity',
            isComplete: _authStep >= 1,
            isActive: _authStep == 1,
          ),
          const SizedBox(height: 12),
          _AuthStep(
            number: 2,
            title: 'Grant Permissions',
            isComplete: _authStep >= 2,
            isActive: _authStep == 2,
          ),
          const SizedBox(height: 12),
          _AuthStep(
            number: 3,
            title: 'Link Account',
            isComplete: _authStep >= 3,
            isActive: _authStep == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildManualLoginView(String? logoAsset) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
              'Login to ${widget.account.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your credentials to link your account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 40),

            // Email/Phone Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email or Phone',
                hintText: 'Enter your email or phone number',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email or phone';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Login Status
            if (_authStep == 1) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBlue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Verifying credentials...'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleManualLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Login & Connect',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            // Security Notice
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'We will never store your password. Your credentials are encrypted end-to-end.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessView(String? logoAsset) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success Animation
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.accentGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: AppColors.accentGreen,
              size: 80,
            ),
          ),
          const SizedBox(height: 32),

          const Text(
            'Successfully Connected!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${widget.account.name} is now linked to your wallet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 48),

          // Account Logo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
          const SizedBox(height: 16),
          Text(
            widget.account.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
          ),
          const SizedBox(height: 16),
          Text(
            'Redirecting...',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthStep extends StatelessWidget {
  final int number;
  final String title;
  final bool isComplete;
  final bool isActive;

  const _AuthStep({
    required this.number,
    required this.title,
    required this.isComplete,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isComplete
            ? AppColors.accentGreen.withOpacity(0.1)
            : isActive
                ? AppColors.primaryBlue.withOpacity(0.1)
                : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isComplete
              ? AppColors.accentGreen
              : isActive
                  ? AppColors.primaryBlue
                  : Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isComplete
                  ? AppColors.accentGreen
                  : isActive
                      ? AppColors.primaryBlue
                      : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isComplete
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : isActive
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          '$number',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isActive || isComplete ? FontWeight.w600 : FontWeight.normal,
              color: isComplete
                  ? AppColors.accentGreen
                  : isActive
                      ? AppColors.primaryBlue
                      : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
