import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../design_system/app_colors.dart';

class CryptoDetailScreen extends StatefulWidget {
  final String name;
  final String symbol;
  final String amount;
  final String value;
  final String change;
  final bool isPositive;

  const CryptoDetailScreen({
    super.key,
    required this.name,
    required this.symbol,
    required this.amount,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  @override
  State<CryptoDetailScreen> createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> with SingleTickerProviderStateMixin {
  String _selectedTimeframe = '1D';
  bool _isAiAnalyzing = false;
  String _aiInsight = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _generateAiInsight();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _generateAiInsight() {
    setState(() {
      _isAiAnalyzing = true;
    });

    // Simulate AI analysis
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isAiAnalyzing = false;
        _aiInsight = _getAiInsightForCrypto(widget.symbol);
      });
    });
  }

  String _getAiInsightForCrypto(String symbol) {
    switch (symbol) {
      case 'BTC':
        return '📈 **Strong Buy Signal**: Bitcoin is showing bullish momentum with RSI at 62. Historical data suggests 78% chance of upward movement in the next 7 days. Consider accumulating on dips below \$44,000.';
      case 'ETH':
        return '🔥 **Trending Up**: Ethereum 2.0 upgrades driving positive sentiment. Network activity up 34% this week. AI predicts potential breakout above \$2,400 with high probability.';
      case 'SOL':
        return '⚠️ **Caution Advised**: Solana experiencing short-term volatility. Wait for confirmation above \$15 resistance level. AI recommends holding current position and monitoring for 48 hours.';
      case 'ADA':
        return '💡 **Accumulation Zone**: Cardano in strategic buy zone. Smart contracts adoption increasing. AI analysis shows 65% probability of 10-15% gain within 2 weeks.';
      default:
        return '📊 AI is analyzing market patterns and will provide insights soon...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildPriceHeader(),
                _buildChart(),
                _buildTimeframeSelector(),
                const SizedBox(height: 24),
                _buildAiInsightsCard(),
                const SizedBox(height: 24),
                _buildTabSection(),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: AppColors.primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryBlue,
                AppColors.accentPurple,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60, 60, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        widget.symbol[0],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.symbol,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                          ),
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
    );
  }

  Widget _buildPriceHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            widget.value,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.isPositive ? Icons.trending_up : Icons.trending_down,
                color: widget.isPositive ? AppColors.accentGreen : AppColors.accentRed,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                widget.change,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: widget.isPositive ? AppColors.accentGreen : AppColors.accentRed,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(24),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _getChartData(),
              isCurved: true,
              color: widget.isPositive ? AppColors.accentGreen : AppColors.accentRed,
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: (widget.isPositive ? AppColors.accentGreen : AppColors.accentRed).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getChartData() {
    // Mock chart data based on timeframe
    switch (_selectedTimeframe) {
      case '1D':
        return [
          const FlSpot(0, 1),
          const FlSpot(1, 1.2),
          const FlSpot(2, 0.9),
          const FlSpot(3, 1.5),
          const FlSpot(4, 1.3),
          const FlSpot(5, 1.8),
        ];
      case '1W':
        return [
          const FlSpot(0, 0.8),
          const FlSpot(1, 1.0),
          const FlSpot(2, 1.3),
          const FlSpot(3, 1.1),
          const FlSpot(4, 1.6),
          const FlSpot(5, 1.8),
        ];
      case '1M':
        return [
          const FlSpot(0, 0.5),
          const FlSpot(1, 0.8),
          const FlSpot(2, 1.2),
          const FlSpot(3, 1.0),
          const FlSpot(4, 1.5),
          const FlSpot(5, 1.8),
        ];
      case '1Y':
        return [
          const FlSpot(0, 0.3),
          const FlSpot(1, 0.6),
          const FlSpot(2, 1.0),
          const FlSpot(3, 0.9),
          const FlSpot(4, 1.4),
          const FlSpot(5, 1.8),
        ];
      default:
        return [];
    }
  }

  Widget _buildTimeframeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: ['1D', '1W', '1M', '3M', '1Y', 'ALL'].map((timeframe) {
          final isSelected = _selectedTimeframe == timeframe;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTimeframe = timeframe;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryBlue : AppColors.divider,
                  ),
                ),
                child: Text(
                  timeframe,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAiInsightsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accentPurple.withOpacity(0.1),
            AppColors.primaryBlue.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accentPurple.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.accentPurple,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'AI Market Insights',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (_isAiAnalyzing)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentPurple),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_isAiAnalyzing)
            Text(
              'AI is analyzing market data, news sentiment, and technical indicators...',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Text(
              _aiInsight,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppColors.textPrimary,
              ),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInsightChip('Technical', Icons.show_chart),
              const SizedBox(width: 8),
              _buildInsightChip('Sentiment', Icons.psychology),
              const SizedBox(width: 8),
              _buildInsightChip('News', Icons.newspaper),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.accentPurple),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.accentPurple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primaryBlue,
          tabs: const [
            Tab(text: 'Stats'),
            Tab(text: 'News'),
            Tab(text: 'Transactions'),
          ],
        ),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildStatsTab(),
              _buildNewsTab(),
              _buildTransactionsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildStatRow('Market Cap', '\$847.3B', Icons.account_balance),
        const SizedBox(height: 12),
        _buildStatRow('24h Volume', '\$32.4B', Icons.show_chart),
        const SizedBox(height: 12),
        _buildStatRow('Circulating Supply', '19.5M ${widget.symbol}', Icons.pie_chart),
        const SizedBox(height: 12),
        _buildStatRow('All-Time High', '\$69,000', Icons.trending_up),
        const SizedBox(height: 12),
        _buildStatRow('All-Time Low', '\$67.81', Icons.trending_down),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.accentPurple),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildNewsCard(
          'Bitcoin ETF Approval Boosts Market',
          '2 hours ago',
          'Major institutional adoption expected...',
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          'Crypto Regulation Update',
          '5 hours ago',
          'New framework announced by SEC...',
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          'Market Analysis: Bull Run Ahead?',
          '1 day ago',
          'Experts predict significant growth...',
        ),
      ],
    );
  }

  Widget _buildNewsCard(String title, String time, String preview) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            preview,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildTransactionItem('Buy', '+0.0123 ${widget.symbol}', '\$542.10', '2 days ago', true),
        const SizedBox(height: 12),
        _buildTransactionItem('Sell', '-0.0056 ${widget.symbol}', '\$245.30', '1 week ago', false),
        const SizedBox(height: 12),
        _buildTransactionItem('Buy', '+0.0234 ${widget.symbol}', '\$1,032.50', '2 weeks ago', true),
      ],
    );
  }

  Widget _buildTransactionItem(String type, String amount, String value, String date, bool isBuy) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (isBuy ? AppColors.accentGreen : AppColors.accentRed).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isBuy ? Icons.add : Icons.remove,
              color: isBuy ? AppColors.accentGreen : AppColors.accentRed,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Buy',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Sell',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
