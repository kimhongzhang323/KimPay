import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../design_system/app_colors.dart';
import '../data/linked_accounts_data.dart';
import '../models/linked_account_models.dart';
import 'account_detail_screen.dart';
import 'add_account_method_screen.dart';

class LinkedAccountsScreen extends StatefulWidget {
  const LinkedAccountsScreen({super.key});

  @override
  State<LinkedAccountsScreen> createState() => _LinkedAccountsScreenState();
}

class _LinkedAccountsScreenState extends State<LinkedAccountsScreen> {
  final List<LinkedAccount> linkedAccounts = LinkedAccountsData.getLinkedAccounts();
  final List<AvailableAccount> availableAccounts = LinkedAccountsData.getAvailableAccounts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Linked Accounts Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Connected Accounts',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton.icon(
                  onPressed: _syncAllAccounts,
                  icon: const Icon(Icons.sync, size: 18),
                  label: const Text('Sync All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Linked Accounts List
            ...linkedAccounts.map((account) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _LinkedAccountCard(
                account: account,
                onTap: () => _showAccountDetails(account),
              ),
            )),
            const SizedBox(height: 32),
            // Available Accounts Section
            const Text(
              'Add More Accounts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            // Available Accounts List
            ...availableAccounts.map((account) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _AvailableAccountCard(
                account: account,
                onTap: () => _connectAccount(account),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _syncAllAccounts() {
    setState(() {
      for (var account in linkedAccounts) {
        account.lastSynced = DateTime.now();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All accounts synced successfully'),
        backgroundColor: AppColors.accentGreen,
      ),
    );
  }

  void _showAccountDetails(LinkedAccount account) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountDetailScreen(account: account),
      ),
    );
  }

  void _connectAccount(AvailableAccount account) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAccountMethodScreen(account: account),
      ),
    );
  }
}

class _LinkedAccountCard extends StatelessWidget {
  final LinkedAccount account;
  final VoidCallback onTap;

  const _LinkedAccountCard({
    required this.account,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: account.currency == 'USD' ? '\$' : account.currency,
      decimalDigits: 2,
    );

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
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: logoAsset != null 
                    ? Colors.white 
                    : AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: logoAsset != null 
                    ? Border.all(color: AppColors.divider, width: 0.5)
                    : null,
              ),
              padding: logoAsset != null ? const EdgeInsets.all(8) : null,
              child: Center(
                child: logoAsset != null
                    ? Image.asset(
                        logoAsset,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _getAccountIcon(account.accountType),
                            color: AppColors.primaryBlue,
                            size: 28,
                          );
                        },
                      )
                    : Icon(
                        _getAccountIcon(account.accountType),
                        color: AppColors.primaryBlue,
                        size: 28,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    account.accountNumber,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        account.isVerified ? Icons.verified : Icons.warning,
                        size: 14,
                        color: account.isVerified
                            ? AppColors.accentGreen
                            : AppColors.accentOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        account.isVerified ? 'Verified' : 'Pending',
                        style: TextStyle(
                          fontSize: 12,
                          color: account.isVerified
                              ? AppColors.accentGreen
                              : AppColors.accentOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currencyFormat.format(account.balance),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getTimeAgo(account.lastSynced),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getAccountIcon(String type) {
    switch (type.toLowerCase()) {
      case 'bank':
        return Icons.account_balance;
      case 'touchngo':
      case 'boost':
      case 'alipay':
      case 'wechat':
        return Icons.account_balance_wallet;
      case 'paypal':
        return Icons.payment;
      default:
        return Icons.account_balance_wallet;
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class _AvailableAccountCard extends StatelessWidget {
  final AvailableAccount account;
  final VoidCallback onTap;

  const _AvailableAccountCard({
    required this.account,
    required this.onTap,
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
    }
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.divider,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: logoAsset != null 
                    ? Colors.white 
                    : AppColors.accentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: logoAsset != null 
                    ? Border.all(color: AppColors.divider, width: 0.5)
                    : null,
              ),
              padding: logoAsset != null ? const EdgeInsets.all(6) : null,
              child: logoAsset != null
                  ? Image.asset(
                      logoAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          _getAccountIcon(account.accountType),
                          color: AppColors.accentGreen,
                          size: 20,
                        );
                      },
                    )
                  : Icon(
                      _getAccountIcon(account.accountType),
                      color: AppColors.accentGreen,
                      size: 20,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    account.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.add_circle_outline,
              color: AppColors.accentGreen,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getAccountIcon(String type) {
    switch (type.toLowerCase()) {
      case 'bank':
        return Icons.account_balance;
      case 'paypal':
        return Icons.payment;
      case 'wechat':
        return Icons.account_balance_wallet;
      default:
        return Icons.account_balance_wallet;
    }
  }
}
