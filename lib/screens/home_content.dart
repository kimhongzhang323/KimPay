import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import '../data/mock_data.dart';
import '../widgets/wallet_card.dart';
import 'send_money_screen.dart';
import 'receive_money_screen.dart';
import 'topup_screen.dart';
import 'scan_screen.dart';
import 'mini_program_screen.dart';
import 'more_programs_screen.dart';
import 'wallet_detail_screen.dart';

class HomeContent extends StatefulWidget {
  final String selectedCurrency;
  final VoidCallback onCurrencyTap;
  final VoidCallback? onNavigateToAIInsights;

  const HomeContent({
    super.key,
    required this.selectedCurrency,
    required this.onCurrencyTap,
    this.onNavigateToAIInsights,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  
  // Smooth page transition helper
  void _navigateWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.05);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          var offsetAnimation = animation.drive(tween);
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          );
          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }
  
  Future<void> _handleRefresh() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(milliseconds: 1500));
    // In a real app, this would reload data from API
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Refreshed successfully!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallets = MockData.getWallets();

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: AppColors.primaryBlue,
      backgroundColor: Colors.white,
      child: CustomScrollView(
        slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: AppColors.background,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '金少',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: widget.onCurrencyTap,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.divider,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.selectedCurrency,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryBlue,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        size: 18,
                                        color: AppColors.primaryBlue,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                icon: const Icon(Icons.notifications_outlined),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Wallet Cards & Bound Cards
              SizedBox(
                height: 200,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Wallet Cards
                    ...wallets.map((wallet) => WalletCard(
                      wallet: wallet,
                      displayCurrency: widget.selectedCurrency,
                      onTap: () => _navigateWithAnimation(
                        context,
                        WalletDetailScreen(wallet: wallet),
                      ),
                    )),
                    // Bound Cards
                    _BoundCardWidget(
                      cardNumber: '**** **** **** 4532',
                      cardType: 'Visa',
                      cardHolder: 'KIM HONG ZHANG',
                      expiryDate: '12/26',
                      isPrimary: true,
                    ),
                    _BoundCardWidget(
                      cardNumber: '**** **** **** 8901',
                      cardType: 'Mastercard',
                      cardHolder: 'KIM HONG ZHANG',
                      expiryDate: '08/27',
                      isPrimary: false,
                    ),
                    // Add Card Button
                    GestureDetector(
                      onTap: () => _showAddCardSheet(context),
                      child: Container(
                        width: 300,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.primaryBlue,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_card,
                              color: AppColors.primaryBlue,
                              size: 48,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Add New Card',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Quick Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _QuickActionButton(
                      icon: Icons.arrow_upward,
                      label: 'Transfer',
                      color: AppColors.accentRed,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const SendMoneyScreen(),
                        );
                      },
                    ),
                    _QuickActionButton(
                      icon: Icons.arrow_downward,
                      label: 'Receive',
                      color: AppColors.accentGreen,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const ReceiveMoneyScreen(),
                        );
                      },
                    ),
                    _QuickActionButton(
                      icon: Icons.qr_code_scanner,
                      label: 'Scan',
                      color: AppColors.primaryBlue,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const ScanScreen(),
                        );
                      },
                    ),
                    _QuickActionButton(
                      icon: Icons.add,
                      label: 'Top Up',
                      color: AppColors.accentPurple,
                      onTap: () => _showTopUpSheet(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // AI Insights Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    if (widget.onNavigateToAIInsights != null) {
                      widget.onNavigateToAIInsights!();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.purpleGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentPurple.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Budget Insights',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Track your spending with AI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Mini Programs Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Mini Programs',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                  children: [
                    _MiniProgramItem(
                      icon: Icons.shopping_bag,
                      label: 'Shop',
                      color: AppColors.accentOrange,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const MiniProgramScreen(
                            title: 'Shop',
                            icon: Icons.shopping_bag,
                            programType: 'shop',
                          ),
                        );
                      },
                    ),
                    _MiniProgramItem(
                      icon: Icons.directions_car,
                      label: 'Ride',
                      color: AppColors.accentGreen,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const MiniProgramScreen(
                            title: 'Ride',
                            icon: Icons.directions_car,
                            programType: 'ride',
                          ),
                        );
                      },
                    ),
                    _MiniProgramItem(
                      icon: Icons.restaurant,
                      label: 'Food',
                      color: AppColors.accentRed,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const MiniProgramScreen(
                            title: 'Food',
                            icon: Icons.restaurant,
                            programType: 'food',
                          ),
                        );
                      },
                    ),
                    _MiniProgramItem(
                      icon: Icons.local_movies,
                      label: 'Movies',
                      color: AppColors.accentPurple,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const MiniProgramScreen(
                            title: 'Movies',
                            icon: Icons.local_movies,
                            programType: 'movies',
                          ),
                        );
                      },
                    ),
                    _MiniProgramItem(
                      icon: Icons.phone_android,
                      label: 'Mobile',
                      color: AppColors.primaryBlue,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const MiniProgramScreen(
                            title: 'Mobile Recharge',
                            icon: Icons.phone_android,
                            programType: 'mobile',
                          ),
                        );
                      },
                    ),
                    _MiniProgramItem(
                      icon: Icons.hotel,
                      label: 'Hotels',
                      color: AppColors.accentOrange,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const MiniProgramScreen(
                            title: 'Hotels',
                            icon: Icons.hotel,
                            programType: 'hotels',
                          ),
                        );
                      },
                    ),
                    _MiniProgramItem(
                      icon: Icons.flight,
                      label: 'Flights',
                      color: AppColors.accentGreen,
                      onTap: () {
                        _navigateWithAnimation(
                          context,
                          const MiniProgramScreen(
                            title: 'Flights',
                            icon: Icons.flight,
                            programType: 'flights',
                          ),
                        );
                      },
                    ),
                    _MiniProgramItem(
                      icon: Icons.more_horiz,
                      label: 'More',
                      color: AppColors.textSecondary,
                      heroTag: 'more_icon',
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                const MoreProgramsScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOutCubic;
                              var tween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve),
                              );
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 400),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
      ),
    );
  }

  void _showTopUpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const _TopUpSheet(),
    );
  }

  void _showAddCardSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _AddCardSheet(),
    );
  }
}

class _QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.90).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.color.withOpacity(0.15),
                    widget.color.withOpacity(0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(widget.icon, color: widget.color, size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniProgramItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;
  final String? heroTag;

  const _MiniProgramItem({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
    this.heroTag,
  });

  @override
  State<_MiniProgramItem> createState() => _MiniProgramItemState();
}

class _MiniProgramItemState extends State<_MiniProgramItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(widget.icon, color: widget.color, size: 24),
    );

    if (widget.heroTag != null) {
      iconWidget = Hero(
        tag: widget.heroTag!,
        child: iconWidget,
      );
    }

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        if (widget.onTap != null) widget.onTap!();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopUpSheet extends StatelessWidget {
  const _TopUpSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Top Up Wallet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...[
            {'name': 'Bank Transfer', 'icon': 'bank', 'logo': null},
            {'name': 'Touch \'n Go', 'icon': 'touchngo', 'logo': 'assets/images/touchngo.png'},
            {'name': 'Boost', 'icon': 'boost', 'logo': 'assets/images/boost.png'},
            {'name': 'Alipay', 'icon': 'alipay', 'logo': 'assets/images/alipay.png'},
            {'name': 'WeChat Pay', 'icon': 'wechat', 'logo': 'assets/images/wechatpay.png'},
            {'name': 'PayPal', 'icon': 'paypal', 'logo': 'assets/images/paypal.png'},
          ].map((method) {
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: method['logo'] != null 
                      ? Colors.white 
                      : AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: method['logo'] != null 
                      ? Border.all(color: AppColors.divider, width: 0.5)
                      : null,
                ),
                padding: method['logo'] != null ? const EdgeInsets.all(6) : null,
                child: method['logo'] != null
                    ? Image.asset(
                        method['logo']!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _getPaymentIcon(method['icon']!),
                            color: AppColors.primaryBlue,
                            size: 20,
                          );
                        },
                      )
                    : Icon(
                        _getPaymentIcon(method['icon']!),
                        color: AppColors.primaryBlue,
                        size: 20,
                      ),
              ),
              title: Text(method['name']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopUpScreen(
                      paymentMethod: method['name']!,
                    ),
                  ),
                );
              },
            );
          }).toList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  IconData _getPaymentIcon(String type) {
    switch (type) {
      case 'bank':
        return Icons.account_balance;
      case 'touchngo':
      case 'boost':
      case 'alipay':
      case 'wechat':
        return Icons.account_balance_wallet;
      case 'apple':
        return Icons.apple;
      default:
        return Icons.payment;
    }
  }
}

class _BoundCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardType;
  final String cardHolder;
  final String expiryDate;
  final bool isPrimary;

  const _BoundCardWidget({
    required this.cardNumber,
    required this.cardType,
    required this.cardHolder,
    required this.expiryDate,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = cardType == 'Visa'
        ? AppColors.primaryGradient
        : AppColors.orangeGradient;

    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardType.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              if (isPrimary)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'PRIMARY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARD HOLDER',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cardHolder,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'EXPIRES',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    expiryDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddCardSheet extends StatefulWidget {
  const _AddCardSheet();

  @override
  State<_AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<_AddCardSheet> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _billingAddressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _otpController = TextEditingController();
  
  int _currentStep = 0;
  String _verificationType = 'SMS'; // SMS or Email
  bool _isOtpSent = false;
  bool _isVerifying = false;
  int _otpTimer = 60;
  
  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _billingAddressController.dispose();
    _postalCodeController.dispose();
    _otpController.dispose();
    super.dispose();
  }
  
  void _sendOtp() {
    setState(() {
      _isOtpSent = true;
      _otpTimer = 60;
    });
    
    // Simulate OTP sending
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Verification code sent to ${_verificationType == 'SMS' ? _phoneController.text : _emailController.text}',
        ),
        backgroundColor: AppColors.accentGreen,
      ),
    );
    
    // Start countdown timer
    Future.delayed(const Duration(seconds: 1), _decrementTimer);
  }
  
  void _decrementTimer() {
    if (_otpTimer > 0) {
      setState(() {
        _otpTimer--;
      });
      Future.delayed(const Duration(seconds: 1), _decrementTimer);
    }
  }
  
  Future<void> _verifyAndAddCard() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isVerifying = true;
    });
    
    // Simulate verification delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Card verified and added successfully!'),
          ],
        ),
        backgroundColor: AppColors.accentGreen,
        duration: Duration(seconds: 3),
      ),
    );
  }
  
  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    }
    String cleaned = value.replaceAll(' ', '');
    if (cleaned.length < 13 || cleaned.length > 19) {
      return 'Invalid card number';
    }
    return null;
  }
  
  String? _validateExpiry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
      return 'Format: MM/YY';
    }
    return null;
  }
  
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }
  
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length < 9 || cleaned.length > 15) {
      return 'Invalid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Progress Indicator
                Row(
                  children: [
                    _buildStepIndicator(0, 'Card Details'),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: _currentStep > 0 ? AppColors.primaryBlue : Colors.grey[300],
                      ),
                    ),
                    _buildStepIndicator(1, 'Billing Info'),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: _currentStep > 1 ? AppColors.primaryBlue : Colors.grey[300],
                      ),
                    ),
                    _buildStepIndicator(2, 'Verify'),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Step Content
                if (_currentStep == 0) _buildCardDetailsStep(),
                if (_currentStep == 1) _buildBillingInfoStep(),
                if (_currentStep == 2) _buildVerificationStep(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStepIndicator(int step, String label) {
    final isActive = _currentStep == step;
    final isCompleted = _currentStep > step;
    
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.accentGreen
                : isActive
                    ? AppColors.primaryBlue
                    : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? AppColors.primaryBlue : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCardDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your credit or debit card information',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        
        TextFormField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Card Number',
            hintText: '1234 5678 9012 3456',
            prefixIcon: Icon(Icons.credit_card),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          validator: _validateCardNumber,
          maxLength: 19,
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _cardHolderController,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'Card Holder Name',
            hintText: 'JOHN DOE',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter name' : null,
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _expiryController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'MM/YY',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: _validateExpiry,
                maxLength: 5,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  hintText: '123',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) => (value?.length ?? 0) < 3 ? 'Invalid CVV' : null,
                maxLength: 4,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _currentStep = 1;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  
  Widget _buildBillingInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Billing Information',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Required for card verification',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: '+60 12-345 6789',
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          validator: _validatePhone,
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email Address',
            hintText: 'john.doe@example.com',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          validator: _validateEmail,
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _billingAddressController,
          textCapitalization: TextCapitalization.words,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Billing Address',
            hintText: '123 Main Street, City',
            prefixIcon: Icon(Icons.home),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter address' : null,
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _postalCodeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Postal Code',
            hintText: '50000',
            prefixIcon: Icon(Icons.pin_drop),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter postal code' : null,
        ),
        
        const SizedBox(height: 24),
        
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep = 0;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _currentStep = 2;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  
  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Verify your identity to complete card registration',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        
        // Verification Method Selection
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              RadioListTile<String>(
                value: 'SMS',
                groupValue: _verificationType,
                onChanged: (value) {
                  setState(() {
                    _verificationType = value!;
                    _isOtpSent = false;
                  });
                },
                title: const Text('SMS OTP'),
                subtitle: Text(_phoneController.text),
                secondary: const Icon(Icons.message),
              ),
              Divider(height: 1, color: Colors.grey[300]),
              RadioListTile<String>(
                value: 'Email',
                groupValue: _verificationType,
                onChanged: (value) {
                  setState(() {
                    _verificationType = value!;
                    _isOtpSent = false;
                  });
                },
                title: const Text('Email OTP'),
                subtitle: Text(_emailController.text),
                secondary: const Icon(Icons.email),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // OTP Input (shown after sending)
        if (_isOtpSent) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primaryBlue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Enter the 6-digit code sent to your ${_verificationType.toLowerCase()}',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 8,
            ),
            decoration: const InputDecoration(
              labelText: 'Verification Code',
              hintText: '000000',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            validator: (value) => (value?.length ?? 0) != 6 ? 'Enter 6-digit code' : null,
            maxLength: 6,
          ),
          
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _otpTimer > 0 ? 'Code expires in $_otpTimer seconds' : 'Code expired',
                style: TextStyle(
                  fontSize: 12,
                  color: _otpTimer > 0 ? AppColors.textSecondary : Colors.red,
                ),
              ),
              TextButton(
                onPressed: _otpTimer == 0 ? _sendOtp : null,
                child: const Text('Resend Code'),
              ),
            ],
          ),
        ],
        
        const SizedBox(height: 24),
        
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _isVerifying ? null : () {
                  setState(() {
                    _currentStep = 1;
                    _isOtpSent = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _isVerifying
                    ? null
                    : _isOtpSent
                        ? _verifyAndAddCard
                        : _sendOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isVerifying
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _isOtpSent ? 'Verify & Add Card' : 'Send Verification Code',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
