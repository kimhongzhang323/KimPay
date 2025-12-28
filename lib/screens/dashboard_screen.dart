import 'package:flutter/material.dart';
import 'home_content.dart';
import 'transactions_screen.dart';
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
  
  // Pages for the new 5-tab layout
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(
        selectedCurrency: 'USD',
        onCurrencyTap: () {},
      ),
      const ExchangeScreen(), // New Exchange Screen as 2nd tab
      const TransactionsScreen(), // Moving Transactions to 3rd? Or keeping layout logical?
      // Based on image: Home | Exchange (Swap) | Analytics (Chart) | Profile | (Clock)
      // I will map:
      // 0: HomeContent
      // 1: ExchangeScreen
      // 2: AIInsightsScreen (Analytics)
      // 3: ProfileScreen
      // 4: TransactionsScreen (History)
      const AIInsightsScreen(), 
      const ProfileScreen(),
      const TransactionsScreen(), // Putting history last
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Always light
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
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
    // If we are on Exchange screen (index 1), we might want the nav bar different or just consistent dark?
    // The design shows the nav bar on Exchange screen is dark too.
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
          _buildNavItem(1, Icons.swap_horiz), // Exchange Icon
          _buildNavItem(2, Icons.pie_chart_outline), // Analytics
          _buildNavItem(3, Icons.person_outline), // Profile
          _buildNavItem(4, Icons.history), // History/Transactions
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
