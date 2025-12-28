import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../design_system/app_colors.dart';

class AIInsightsScreen extends StatefulWidget {
  const AIInsightsScreen({super.key});

  @override
  State<AIInsightsScreen> createState() => _AIInsightsScreenState();
}

class _AIInsightsScreenState extends State<AIInsightsScreen> {
  // 0: Analytics, 1: Budget, 2: Goals (Not really used in new design but keeping state structure)
  
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
              _buildAccountSelector(),
              const SizedBox(height: 24),
              _buildAnalyticsCard(),
              const SizedBox(height: 32),
              _buildBudgetSection(),
              const SizedBox(height: 32),
              _buildCategoriesGrid(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            onPressed: () {
               if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        const Text(
          'Analytics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.more_vert, size: 20, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Account',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.transparent), // Simplified
          ),
          child: Row(
            children: [
              const Icon(Icons.apple, size: 28), // Placeholder icon
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Kimmy', // Updated to User Name
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '.... .... .... 7845',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                '\$8,182.80',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A), // Dark black/grey
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Analytics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_outward, size: 16, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xFF4ADE80), // Green
                            value: 40,
                            radius: 12, // Thinner
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFFBBF24), // Yellow
                            value: 20,
                            radius: 18, // Thicker
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFF60A5FA), // Blue
                            value: 15,
                            radius: 14,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            color: const Color(0xFFA78BFA), // Purple
                            value: 25,
                            radius: 16,
                            showTitle: false,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            '\$8,182',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildLegendItem('Earned', '\$40,911', const Color(0xFF4ADE80)),
                    const SizedBox(height: 12),
                    _buildLegendItem('Spent', '\$12,273', const Color(0xFFA78BFA)),
                    const SizedBox(height: 12),
                    _buildLegendItem('Available', '\$8,182', const Color(0xFFFBBF24)),
                    const SizedBox(height: 12),
                    _buildLegendItem('Savings', '\$4,091', const Color(0xFF60A5FA)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Budget for March',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Icon(Icons.edit, size: 16, color: Colors.grey[400]),
          ],
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: 0.4,
          backgroundColor: Colors.grey[200],
          color: const Color(0xFFA78BFA), // Purple
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 8),
        const Text(
          'Amount: \$20,256',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    final categories = [
      {'name': 'Bills', 'amount': '\$620.00', 'items': '12 items', 'icon': Icons.receipt_long},
      {'name': 'Food', 'amount': '\$320.00', 'items': '15 items', 'icon': Icons.restaurant},
      {'name': 'Utilities', 'amount': '\$120.00', 'items': '20 items', 'icon': Icons.tv},
      {'name': 'Health', 'amount': '\$450.00', 'items': '08 items', 'icon': Icons.favorite},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: categories.map((cat) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(cat['icon'] as IconData, size: 20, color: Colors.black87),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      cat['items'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat['name'] as String,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cat['amount'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
