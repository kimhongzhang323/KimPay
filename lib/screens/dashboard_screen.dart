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
  String selectedRegion = 'MY'; // Malaysia
  String selectedCurrency = 'MYR';
  late final List<Widget> _pages;

  final Map<String, Map<String, String>> _regions = {
    'MY': {'name': 'Malaysia', 'currency': 'MYR', 'flagCode': 'my'},
    'US': {'name': 'United States', 'currency': 'USD', 'flagCode': 'us'},
    'SG': {'name': 'Singapore', 'currency': 'SGD', 'flagCode': 'sg'},
    'GB': {'name': 'United Kingdom', 'currency': 'GBP', 'flagCode': 'gb'},
    'FR': {'name': 'France (EUR)', 'currency': 'EUR', 'flagCode': 'fr'},
    'JP': {'name': 'Japan', 'currency': 'JPY', 'flagCode': 'jp'},
    'CN': {'name': 'China', 'currency': 'CNY', 'flagCode': 'cn'},
    'AU': {'name': 'Australia', 'currency': 'AUD', 'flagCode': 'au'},
    'TH': {'name': 'Thailand', 'currency': 'THB', 'flagCode': 'th'},
    'ID': {'name': 'Indonesia', 'currency': 'IDR', 'flagCode': 'id'},
    'PH': {'name': 'Philippines', 'currency': 'PHP', 'flagCode': 'ph'},
    'VN': {'name': 'Vietnam', 'currency': 'VND', 'flagCode': 'vn'},
  };

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(
        selectedCurrency: selectedCurrency,
        onCurrencyTap: () => _showRegionPicker(),
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

  void _showRegionPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
                'Select Region',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Choose your region to see localized content',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: ListView(
                shrinkWrap: true,
                children: _regions.entries.map((entry) {
                  final regionCode = entry.key;
                  final regionData = entry.value;
                  final isSelected = selectedRegion == regionCode;
                  
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? AppColors.primaryBlue.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryBlue.withOpacity(0.3)
                              : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          'assets/images/countryFlag/${regionData['flagCode']}.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.flag,
                              size: 20,
                              color: AppColors.primaryBlue,
                            );
                          },
                        ),
                      ),
                    ),
                    title: Text(
                      regionData['name']!,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      regionData['currency']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: AppColors.primaryBlue)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedRegion = regionCode;
                        selectedCurrency = regionData['currency']!;
                        _pages[0] = HomeContent(
                          selectedCurrency: selectedCurrency,
                          onCurrencyTap: () => _showRegionPicker(),
                          onNavigateToAIInsights: () {
                            setState(() {
                              _selectedIndex = 3;
                            });
                          },
                        );
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  'assets/images/countryFlag/${regionData['flagCode']}.png',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.flag,
                                      size: 24,
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text('Switched to ${regionData['name']}'),
                            ],
                          ),
                          backgroundColor: AppColors.accentGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
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
