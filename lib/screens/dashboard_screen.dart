import 'package:flutter/material.dart';
import 'home_content.dart';
import 'scan_screen.dart'; // Changed from TransactionsScreen
import 'exchange_screen.dart'; // New Import
import 'ai_insights_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _selectedCurrency = 'MYR';

  void _updateCurrency(String newCurrency) {
    setState(() {
      _selectedCurrency = newCurrency;
    });
  }

  List<Widget> get _pages {
    return [
      HomeContent(
        selectedCurrency: _selectedCurrency,
        onCurrencyTap: () {}, 
        onCurrencyChanged: _updateCurrency,
      ),
      ExchangeScreen(selectedCurrency: _selectedCurrency),
      const ScanScreen(), // Index 2: Center (QR Scanner)
      AIInsightsScreen(selectedCurrency: _selectedCurrency), // Index 3
      ProfileScreen(selectedCurrency: _selectedCurrency), // Index 4: Profile
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Always light
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.home_rounded),
          _buildNavItem(1, Icons.swap_horiz), // Exchange
          _buildNavItem(2, Icons.qr_code_scanner), // Scan
          _buildNavItem(3, Icons.pie_chart_outline), // Analytics
          _buildNavItem(4, Icons.person_outline), // Profile
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}
