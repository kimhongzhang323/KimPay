import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import 'home_content.dart';
import 'linked_accounts_screen.dart';
import 'transactions_screen.dart';
import 'ai_insights_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String selectedCurrency = 'USD';
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(
        selectedCurrency: selectedCurrency,
        onCurrencyTap: () => _showCurrencyPicker(),
        onNavigateToAIInsights: () {
          setState(() {
            _selectedIndex = 3; // Navigate to AI Insights tab
          });
        },
      ),
      const LinkedAccountsScreen(),
      const TransactionsScreen(),
      const AIInsightsScreen(),
      const ProfileScreen(),
    ];
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Select Currency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...['USD', 'EUR', 'GBP', 'JPY', 'CNY', 'MYR', 'SGD', 'AUD']
                .map((currency) => ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text(_getCurrencyName(currency)),
                      trailing: selectedCurrency == currency
                          ? const Icon(Icons.check, color: AppColors.primaryBlue)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedCurrency = currency;
                          _pages[0] = HomeContent(
                            selectedCurrency: selectedCurrency,
                            onCurrencyTap: () => _showCurrencyPicker(),
                            onNavigateToAIInsights: () {
                              setState(() {
                                _selectedIndex = 3;
                              });
                            },
                          );
                        });
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getCurrencyName(String code) {
    switch (code) {
      case 'USD':
        return 'US Dollar';
      case 'EUR':
        return 'Euro';
      case 'GBP':
        return 'British Pound';
      case 'JPY':
        return 'Japanese Yen';
      case 'CNY':
        return 'Chinese Yuan';
      case 'MYR':
        return 'Malaysian Ringgit';
      case 'SGD':
        return 'Singapore Dollar';
      case 'AUD':
        return 'Australian Dollar';
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', 0),
              _buildNavItem(Icons.account_balance_wallet, 'Accounts', 1),
              _buildNavItem(Icons.receipt_long, 'Transactions', 2),
              _buildNavItem(Icons.auto_awesome, 'AI', 3),
              _buildNavItem(Icons.person, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
