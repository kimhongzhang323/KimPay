import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';

class MoreProgramsScreen extends StatefulWidget {
  const MoreProgramsScreen({super.key});

  @override
  State<MoreProgramsScreen> createState() => _MoreProgramsScreenState();
}

class _MoreProgramsScreenState extends State<MoreProgramsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryBlue,
                      AppColors.primaryBlue.withOpacity(0.9),
                      AppColors.accentPurple.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 70, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: 'more_icon',
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.apps_rounded,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'More Services',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Everything you need in one place',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
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
                ),
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary.withOpacity(0.6),
                      fontSize: 15,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.primaryBlue.withOpacity(0.7),
                      size: 24,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear_rounded,
                              color: AppColors.textSecondary.withOpacity(0.6),
                              size: 20,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Category Tabs
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryBlue,
                      AppColors.primaryBlue.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                tabs: const [
                  Tab(text: '🌟 Popular'),
                  Tab(text: '✈️ Travel'),
                  Tab(text: '💼 Lifestyle'),
                  Tab(text: '🏦 Finance'),
                  Tab(text: '🛍️ More'),
                ],
              ),
            ),
          ),

          // Programs Grid
          SliverToBoxAdapter(
            child: SizedBox(
              height: 700, // Fixed height for TabBarView
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPopularSection(),
                  _buildTravelSection(),
                  _buildLifestyleSection(),
                  _buildFinanceSection(),
                  _buildMoreSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Most Used Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: [
              _ServiceCard(
                icon: Icons.phone_android,
                label: 'eSIM',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('eSIM'),
              ),
              _ServiceCard(
                icon: Icons.card_giftcard,
                label: 'Gift Cards',
                color: AppColors.accentOrange,
                onTap: () => _showComingSoon('Gift Cards'),
              ),
              _ServiceCard(
                icon: Icons.local_parking,
                label: 'Parking',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('Parking'),
              ),
              _ServiceCard(
                icon: Icons.receipt_long,
                label: 'Bills',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Bills'),
              ),
              _ServiceCard(
                icon: Icons.lightbulb,
                label: 'Utilities',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Utilities'),
              ),
              _ServiceCard(
                icon: Icons.directions_bus,
                label: 'Transit',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Transit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTravelSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Travel & Transportation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: [
              _ServiceCard(
                icon: Icons.flight_takeoff,
                label: 'Airport Shuttle',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Airport Shuttle'),
              ),
              _ServiceCard(
                icon: Icons.train,
                label: 'Train Tickets',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('Train Tickets'),
              ),
              _ServiceCard(
                icon: Icons.directions_bus,
                label: 'Bus Tickets',
                color: AppColors.accentOrange,
                onTap: () => _showComingSoon('Bus Tickets'),
              ),
              _ServiceCard(
                icon: Icons.directions_car,
                label: 'Car Rental',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Car Rental'),
              ),
              _ServiceCard(
                icon: Icons.sim_card,
                label: 'Travel eSIM',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Travel eSIM'),
              ),
              _ServiceCard(
                icon: Icons.local_activity,
                label: 'Attractions',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Attractions'),
              ),
              _ServiceCard(
                icon: Icons.umbrella,
                label: 'Travel Insurance',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('Travel Insurance'),
              ),
              _ServiceCard(
                icon: Icons.luggage,
                label: 'Luggage Storage',
                color: AppColors.accentOrange,
                onTap: () => _showComingSoon('Luggage Storage'),
              ),
              _ServiceCard(
                icon: Icons.currency_exchange,
                label: 'Currency Exchange',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Currency Exchange'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLifestyleSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Lifestyle Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: [
              _ServiceCard(
                icon: Icons.fitness_center,
                label: 'Fitness',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('Fitness'),
              ),
              _ServiceCard(
                icon: Icons.spa,
                label: 'Beauty & Spa',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Beauty & Spa'),
              ),
              _ServiceCard(
                icon: Icons.medical_services,
                label: 'Healthcare',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Healthcare'),
              ),
              _ServiceCard(
                icon: Icons.school,
                label: 'Education',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Education'),
              ),
              _ServiceCard(
                icon: Icons.pets,
                label: 'Pet Services',
                color: AppColors.accentOrange,
                onTap: () => _showComingSoon('Pet Services'),
              ),
              _ServiceCard(
                icon: Icons.cleaning_services,
                label: 'Cleaning',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('Cleaning'),
              ),
              _ServiceCard(
                icon: Icons.local_laundry_service,
                label: 'Laundry',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Laundry'),
              ),
              _ServiceCard(
                icon: Icons.home_repair_service,
                label: 'Home Services',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Home Services'),
              ),
              _ServiceCard(
                icon: Icons.event,
                label: 'Events',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Events'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFinanceSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Financial Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: [
              _ServiceCard(
                icon: Icons.savings,
                label: 'Savings',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('Savings'),
              ),
              _ServiceCard(
                icon: Icons.account_balance,
                label: 'Loans',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Loans'),
              ),
              _ServiceCard(
                icon: Icons.shield,
                label: 'Insurance',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Insurance'),
              ),
              _ServiceCard(
                icon: Icons.trending_up,
                label: 'Investment',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Investment'),
              ),
              _ServiceCard(
                icon: Icons.currency_bitcoin,
                label: 'Crypto',
                color: AppColors.accentOrange,
                onTap: () => _showComingSoon('Crypto'),
              ),
              _ServiceCard(
                icon: Icons.credit_score,
                label: 'Credit Score',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('Credit Score'),
              ),
              _ServiceCard(
                icon: Icons.account_balance_wallet,
                label: 'Budgeting',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Budgeting'),
              ),
              _ServiceCard(
                icon: Icons.payment,
                label: 'Pay Later',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Pay Later'),
              ),
              _ServiceCard(
                icon: Icons.auto_awesome,
                label: 'Rewards',
                color: AppColors.accentOrange,
                onTap: () => _showComingSoon('Rewards'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMoreSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'More Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: [
              _ServiceCard(
                icon: Icons.favorite,
                label: 'Charity',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Charity'),
              ),
              _ServiceCard(
                icon: Icons.card_membership,
                label: 'Memberships',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Memberships'),
              ),
              _ServiceCard(
                icon: Icons.games,
                label: 'Gaming',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Gaming'),
              ),
              _ServiceCard(
                icon: Icons.music_note,
                label: 'Entertainment',
                color: AppColors.accentOrange,
                onTap: () => _showComingSoon('Entertainment'),
              ),
              _ServiceCard(
                icon: Icons.newspaper,
                label: 'News',
                color: AppColors.accentGreen,
                onTap: () => _showComingSoon('News'),
              ),
              _ServiceCard(
                icon: Icons.book,
                label: 'Books',
                color: AppColors.primaryBlue,
                onTap: () => _showComingSoon('Books'),
              ),
              _ServiceCard(
                icon: Icons.volunteer_activism,
                label: 'Donations',
                color: AppColors.accentRed,
                onTap: () => _showComingSoon('Donations'),
              ),
              _ServiceCard(
                icon: Icons.group,
                label: 'Social',
                color: AppColors.accentPurple,
                onTap: () => _showComingSoon('Social'),
              ),
              _ServiceCard(
                icon: Icons.settings,
                label: 'Settings',
                color: AppColors.textSecondary,
                onTap: () => _showComingSoon('Settings'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showComingSoon(String service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    service,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Coming soon! Stay tuned',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
