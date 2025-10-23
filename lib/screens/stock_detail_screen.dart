import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../design_system/app_colors.dart';

class StockDetailScreen extends StatefulWidget {
  final String name;
  final String symbol;
  final String shares;
  final String value;
  final String change;
  final bool isPositive;

  const StockDetailScreen({
    super.key,
    required this.name,
    required this.symbol,
    required this.shares,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> with SingleTickerProviderStateMixin {
  String _selectedTimeframe = '1D';
  bool _isAiAnalyzing = false;
  String _aiRecommendation = '';
  String _aiSentiment = '';
  String _aiRiskLevel = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _performAiAnalysis();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _performAiAnalysis() {
    setState(() {
      _isAiAnalyzing = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isAiAnalyzing = false;
        _aiRecommendation = _getRecommendation();
        _aiSentiment = _getSentiment();
        _aiRiskLevel = _getRiskLevel();
      });
    });
  }

  String _getRecommendation() {
    if (widget.symbol == 'AAPL') {
      return '🟢 **Strong Buy**: Apple shows robust fundamentals with iPhone 16 sales exceeding expectations. AI predicts 15-20% upside potential. Recent earnings beat by 8%. Target price: \$195-205.';
    } else if (widget.symbol == 'TSLA') {
      return '🟡 **Hold**: Tesla in consolidation phase. Wait for breakout above \$255. AI monitors production numbers and Cybertruck delivery data. Reassess in 2 weeks.';
    } else if (widget.symbol == 'MSFT') {
      return '🟢 **Buy**: Microsoft Azure growth accelerating. AI division showing 45% YoY revenue increase. Strong institutional accumulation detected. Entry point: \$380-385.';
    } else {
      return '🟡 **Neutral**: Monitor market conditions. AI tracking key support/resistance levels and volume patterns.';
    }
  }

  String _getSentiment() {
    final sentimentScore = (widget.hashCode % 30) + 55;
    if (sentimentScore > 70) {
      return 'Very Positive ($sentimentScore/100)\nNews: 85% positive articles\nSocial: Bullish trend on financial platforms\nAnalyst: 12 upgrades, 2 downgrades (last 30 days)';
    } else if (sentimentScore > 50) {
      return 'Positive ($sentimentScore/100)\nNews: 68% positive coverage\nSocial: Moderate bullish sentiment\nAnalyst: Majority hold with buy bias';
    } else {
      return 'Neutral ($sentimentScore/100)\nNews: Mixed coverage\nSocial: No clear trend\nAnalyst: Hold consensus';
    }
  }

  String _getRiskLevel() {
    if (widget.symbol == 'AAPL' || widget.symbol == 'MSFT') {
      return 'Low-Medium Risk\n• Beta: 1.2 (below market average)\n• Volatility: 15% (stable)\n• Liquidity: Excellent\n• Diversification: Recommended position size 5-8%';
    } else if (widget.symbol == 'TSLA') {
      return 'Medium-High Risk\n• Beta: 1.8 (above market average)\n• Volatility: 35% (high)\n• Liquidity: Good\n• Diversification: Limit to 3-5% of portfolio';
    } else {
      return 'Medium Risk\n• Beta: 1.4\n• Volatility: 22%\n• Liquidity: Good\n• Diversification: 4-6% position size';
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
                _buildKeyMetrics(),
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
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.star_border, color: Colors.white),
          onPressed: () {},
        ),
      ],
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
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.shares} shares owned',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ),
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
    switch (_selectedTimeframe) {
      case '1D':
        return [
          const FlSpot(0, 1.2),
          const FlSpot(1, 1.4),
          const FlSpot(2, 1.1),
          const FlSpot(3, 1.6),
          const FlSpot(4, 1.5),
          const FlSpot(5, 1.9),
        ];
      case '1W':
        return [
          const FlSpot(0, 0.9),
          const FlSpot(1, 1.1),
          const FlSpot(2, 1.4),
          const FlSpot(3, 1.2),
          const FlSpot(4, 1.7),
          const FlSpot(5, 1.9),
        ];
      case '1M':
        return [
          const FlSpot(0, 0.6),
          const FlSpot(1, 0.9),
          const FlSpot(2, 1.3),
          const FlSpot(3, 1.1),
          const FlSpot(4, 1.6),
          const FlSpot(5, 1.9),
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
                'AI Stock Analysis',
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
          const SizedBox(height: 20),
          if (_isAiAnalyzing)
            Text(
              'AI is analyzing fundamentals, technicals, news, and market sentiment...',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnalysisSection('💡 Recommendation', _aiRecommendation),
                const SizedBox(height: 16),
                _buildAnalysisSection('📊 Market Sentiment', _aiSentiment),
                const SizedBox(height: 16),
                _buildAnalysisSection('⚠️ Risk Assessment', _aiRiskLevel),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.accentPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            height: 1.5,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildKeyMetrics() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Key Metrics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildMetricCard('P/E Ratio', '28.5', Icons.analytics)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('Market Cap', '\$2.8T', Icons.public)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Dividend', '2.4%', Icons.payments)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('52W High', '\$198.23', Icons.trending_up)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.accentPurple),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
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
            Tab(text: 'Financials'),
            Tab(text: 'News'),
            Tab(text: 'Orders'),
          ],
        ),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildFinancialsTab(),
              _buildNewsTab(),
              _buildOrdersTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialsTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildFinancialRow('Revenue (TTM)', '\$394.3B', Icons.monetization_on),
        const SizedBox(height: 12),
        _buildFinancialRow('Net Income', '\$97.0B', Icons.account_balance),
        const SizedBox(height: 12),
        _buildFinancialRow('EPS', '\$6.13', Icons.show_chart),
        const SizedBox(height: 12),
        _buildFinancialRow('ROE', '147.4%', Icons.trending_up),
        const SizedBox(height: 12),
        _buildFinancialRow('Debt/Equity', '1.79', Icons.balance),
      ],
    );
  }

  Widget _buildFinancialRow(String label, String value, IconData icon) {
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
          'Q4 Earnings Beat Expectations',
          '1 hour ago',
          'Company reports record revenue...',
          true,
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          'New Product Launch Announced',
          '4 hours ago',
          'Revolutionary technology unveiled...',
          true,
        ),
        const SizedBox(height: 12),
        _buildNewsCard(
          'Analyst Upgrade to Strong Buy',
          '1 day ago',
          'Major investment firm increases target...',
          true,
        ),
      ],
    );
  }

  Widget _buildNewsCard(String title, String time, String preview, bool isPositive) {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.accentGreen : AppColors.accentRed).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isPositive ? 'Bullish' : 'Bearish',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isPositive ? AppColors.accentGreen : AppColors.accentRed,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildOrderItem('Buy', '15 shares', '\$2,745.50', '1 week ago', true),
        const SizedBox(height: 12),
        _buildOrderItem('Sell', '8 shares', '\$1,472.00', '2 weeks ago', false),
        const SizedBox(height: 12),
        _buildOrderItem('Buy', '22 shares', '\$3,982.40', '1 month ago', true),
      ],
    );
  }

  Widget _buildOrderItem(String type, String shares, String total, String date, bool isBuy) {
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
              isBuy ? Icons.arrow_downward : Icons.arrow_upward,
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
                  '$shares • $date',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            total,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
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
