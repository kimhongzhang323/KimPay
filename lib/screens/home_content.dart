import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import '../data/mock_data.dart';
// import '../widgets/wallet_card.dart'; // Using custom local card for new design
import 'send_money_screen.dart';
import 'receive_money_screen.dart';
import 'topup_screen.dart';
import 'scan_screen.dart';
import 'mini_program_screen.dart';
import 'more_programs_screen.dart';
import 'transactions_screen.dart';
import 'wallet_detail_screen.dart';

class HomeContent extends StatefulWidget {
  final String selectedCurrency;
  final VoidCallback onCurrencyTap;
  final VoidCallback? onNavigateToAIInsights;
  final Function(String) onCurrencyChanged;

  const HomeContent({
    super.key,
    required this.selectedCurrency,
    required this.onCurrencyTap,
    required this.onCurrencyChanged,
    this.onNavigateToAIInsights,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Currency State
  late String _currentCurrency;
  double _balance = 8182.80;
  
  @override
  void initState() {
    super.initState();
    _currentCurrency = widget.selectedCurrency;
  }

  @override
  void didUpdateWidget(HomeContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCurrency != oldWidget.selectedCurrency) {
      setState(() {
        // When the parent's selectedCurrency changes, we need to update the local _currentCurrency
        // and re-calculate _balance to reflect the new currency.
        // The _balance is currently stored in the old _currentCurrency.
        double baseAmount = _balance / _exchangeRates[_currentCurrency]!;
        _currentCurrency = widget.selectedCurrency;
        _balance = baseAmount * _exchangeRates[_currentCurrency]!;
      });
    }
  }
  
  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'MYR': 4.65,
    'SGD': 1.35,
    'EUR': 0.92,
    'GBP': 0.79,
    'IDR': 15500.0,
  };
  
  String get _currencySymbol {
    switch(_currentCurrency) {
      case 'MYR': return 'RM';
      case 'SGD': return 'S\$';
      case 'EUR': return '€';
      case 'GBP': return '£';
      case 'IDR': return 'Rp';
      default: return '\$';
    }
  }

  final Map<String, String> _currencyFlags = {
    'USD': 'assets/images/countryFlag/us.png',
    'MYR': 'assets/images/countryFlag/my.png',
    'SGD': 'assets/images/countryFlag/sg.png',
    'EUR': 'assets/images/countryFlag/eu.png', // Assuming eu.png exists, checking file list... wait, 'eu' not in list. using generic or skipped. 
    // Checking list again: 'fr', 'de', 'it' exist. EUR is tricky. Let's use 'eu.png' if I missed it or default to 'fr.png' as proxy or just remove flag for now. 
    // Wait, the list has 'gb.png' for GBP. 
    // Let's check 'eu' again. 'er', 'es', 'et'. No 'eu'.
    // I will map EUR to a prominent Euro country like DE or FR, or just handle gracefully. Let's use 'de.png' (Germany) for EUR for now or maybe I can find a 'eu' one?
    // actually, let's use a generic icon or just Germany 'de.png' for now.
    // 'IDR' -> 'id.png'.
    // 'GBP' -> 'gb.png'.
  };

  // Correction: I should probably double check if I have a eu flag. 
  // Let's just use 'de.png' for EUR for now. 
  
  final Map<String, String> _currencyAssets = {
    'USD': 'assets/images/countryFlag/us.png',
    'MYR': 'assets/images/countryFlag/my.png',
    'SGD': 'assets/images/countryFlag/sg.png',
    'EUR': 'assets/images/countryFlag/de.png', // Using DE for Euro
    'GBP': 'assets/images/countryFlag/gb.png',
    'IDR': 'assets/images/countryFlag/id.png',
  };

  void _updateCurrency(String newCurrency) {
    setState(() {
      double baseAmount = _balance / _exchangeRates[_currentCurrency]!;
      _currentCurrency = newCurrency;
      _balance = baseAmount * _exchangeRates[newCurrency]!;
    });
  }

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _showNotificationOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dismissible background
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Dropdown content
          Positioned(
            width: 320,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(-280, 50), // Position to the left and down
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                child: Container(
                  height: 350,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Notifications',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Mark all read',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          children: [
                             _buildNotificationItem(
                                'Payment Received',
                                'You received RM50.00 from John Doe',
                                '2 mins ago',
                                Icons.arrow_downward,
                                Colors.green,
                              ),
                              _buildNotificationItem(
                                'Payment Successful',
                                'Payment to Starbucks was successful',
                                '1 hour ago',
                                Icons.check,
                                Colors.blue,
                              ),
                              _buildNotificationItem(
                                'Top Up Successful',
                                'Top up RM100.00',
                                'Yesterday',
                                Icons.account_balance_wallet,
                                Colors.orange,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  void _showCurrencySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Currency',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: _exchangeRates.keys.map((currency) {
                  return ListTile(
                    onTap: () {
                      _updateCurrency(currency);
                      Navigator.pop(context);
                    },
                    leading:  ClipOval(
                      child: Image.asset(
                        _currencyAssets[currency]!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag),
                      ),
                    ),
                    title: Text(
                      currency,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    trailing: _currentCurrency == currency
                        ? const Icon(Icons.check_circle, color: AppColors.primaryBlue)
                        : null,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildWalletCard(),
              const SizedBox(height: 32),
              _buildQuickActions(),
              const SizedBox(height: 32),
              _buildManageExpenses(),
              const SizedBox(height: 80), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align everything to the right since we removed the left menu
      children: [
        Row(
          children: [
            // Notification with Badge
            GestureDetector(
              onTap: () {
                _showNotificationOverlay(context);
              },
              child: CompositedTransformTarget(
                link: _layerLink,
                child: Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_outlined, size: 20),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello Kimmy!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Let\'s save your money.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 280,
          child: Stack(
            children: [
              // 1. Background Peek (Yellow/Orange)
              Positioned(
                top: 0,
                left: 20,
                right: 20,
                child: Container(
                  height: 160,
                  padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFCC80),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40, 
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.compare_arrows, color: Colors.white, size: 16),
                      ),
                      const Text(
                        '.... .... .... 2585',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // 2. Main Card (Purple) and Add Button Container
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    // The Purple Card
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6),
                        borderRadius: BorderRadius.circular(36),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Row: Apple Icon and Number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.apple, color: Colors.white, size: 32),
                              Text(
                                '.... .... .... 7845',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Balance Section with Selector
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Balance',
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                              GestureDetector(
                                onTap: _showCurrencySelector,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          _currencyAssets[_currentCurrency]!,
                                          width: 16,
                                          height: 16,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        _currentCurrency,
                                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 14),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _currentCurrency == 'IDR' // Special case for IDR usually no decimal
                                ? '$_currencySymbol ${_balance.toStringAsFixed(0)}'
                                : '$_currencySymbol${_balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Bottom Row: Name and Exp Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Name', style: TextStyle(color: Colors.white70, fontSize: 11)),
                                  SizedBox(height: 2),
                                  Text(
                                    'Kimmy',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 80.0), // Space for the cut-out button
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Exp. Date', style: TextStyle(color: Colors.white70, fontSize: 11)),
                                    SizedBox(height: 2),
                                    Text(
                                      '08/26',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // The "Add Card" Button Cutout Effect
                    // Positioned at Bottom Right
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 70, // Size of the cutout area
                        width: 140, // extended to the left
                        decoration: const BoxDecoration(
                            color: Color(0xFFF5F6FA), // Match Scaffold background to create "cutout" illusion
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                           ),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, left: 8), // inset slightly
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F1F1F), // Dark Button
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add, size: 16, color: Colors.black),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Add Card',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildQuickActionItem(Icons.arrow_outward, 'Send', () => _navigateWithAnimation(context, const SendMoneyScreen())),
        _buildQuickActionItem(Icons.arrow_downward, 'Request', () => _navigateWithAnimation(context, const ReceiveMoneyScreen())),
        _buildQuickActionItem(Icons.account_balance_wallet, 'TopUp', () => _navigateWithAnimation(context, const TopUpScreen(paymentMethod: 'Bank Transfer'))),
        _buildQuickActionItem(Icons.more_horiz, 'More', () => _navigateWithAnimation(context, const MoreProgramsScreen())),
      ],
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageExpenses() {
    final List<Map<String, dynamic>> transactions = [
      {
        'logo': 'assets/images/grab.png',
        'title': 'Grab Transport',
        'subtitle': '10:00 am • 08 March, 2025',
        'amount': 24.00,
      },
      {
        'logo': 'assets/images/agoda.png',
        'title': 'Agoda Hotel',
        'subtitle': '12:00 pm • 08 March, 2025',
        'amount': 120.00,
      },
      {
        'logo': 'assets/images/touchngo.png',
        'title': 'Touch \'n Go',
        'subtitle': '04:30 pm • 07 March, 2025',
        'amount': 50.00,
      },
      {
        'logo': 'assets/images/boost.png',
        'title': 'Boost Topup',
        'subtitle': '09:15 am • 06 March, 2025',
        'amount': 30.00,
      },
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                 Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => TransactionsScreen(selectedCurrency: _currentCurrency)
                  )
                ); 
              },
              child: const Text('View All'),
            ),
          ],
        ),
        ...transactions.map((tx) {
           double originalAmount = (tx['amount'] as double);
           double convertedAmount = originalAmount * (_exchangeRates[_currentCurrency] ?? 1.0);
           String sign = '-';
           String formatted = '$sign$_currencySymbol${convertedAmount.toStringAsFixed(2)}';
           
           return _buildExpenseItem(
            logoPath: tx['logo'] as String,
            title: tx['title'] as String,
            subtitle: tx['subtitle'] as String,
            amount: formatted,
          );
        }),
      ],
    );
  }

  Widget _buildExpenseItem({
    required String logoPath,
    required String title,
    required String subtitle,
    required String amount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
           BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
                child: Image.asset(
                  logoPath, 
                  fit: BoxFit.cover,
                  errorBuilder: (c,o,s) => const Icon(Icons.receipt, color: Colors.grey),
                ),
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
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: amount.startsWith('-') ? Colors.red : AppColors.accentGreen,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNotificationItem(String title, String subtitle, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
