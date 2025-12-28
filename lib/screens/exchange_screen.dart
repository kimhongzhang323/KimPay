import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../design_system/app_colors.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  String _selectedRange = '1W';
  final List<String> _ranges = ['1H', '1D', '1W', '1M', '1Y'];
  
  double _sendAmount = 1000.0;
  
  // Exchange State
  String _fromCurrency = 'USD';
  String _toCurrency = 'ETH';

  final Map<String, double> _cryptoRatesInUSD = {
    'ETH': 3500.0,
    'BTC': 65000.0,
    'SOL': 145.0,
    'LTC': 85.0,
    'DOGE': 0.15,
  };

  final Map<String, double> _fiatRatesFromUSD = {
    'USD': 1.0,
    'MYR': 4.65,
    'SGD': 1.35,
    'EUR': 0.92,
    'GBP': 0.79,
    'IDR': 15500.0,
  };

  // Icon mapping
  final Map<String, String> _fiatFlags = {
    'USD': '🇺🇸',
    'MYR': '🇲🇾',
    'SGD': '🇸🇬',
    'EUR': '🇪🇺',
    'GBP': '🇬🇧',
    'IDR': '🇮🇩',
  };

  // Helper to get rates
  double get _currentRate {
    // 1. Get Value of 1 Unit of FromCurrency in USD
    double fromInUSD = 1.0 / _fiatRatesFromUSD[_fromCurrency]!;
    
    // 2. Get Value of 1 Unit of ToCurrency in USD
    double toInUSD = _cryptoRatesInUSD[_toCurrency] ?? 1.0; 
    // If toCurrency was fiat, we'd handle it differently, but requirement implies Crypto/Exchange
    
    // 3. Return how many ToCurrency per 1 FromCurrency
    return fromInUSD / toInUSD; 
  }

  double get _receiveAmount => _sendAmount * _currentRate;

  void _showAmountDialog() {
    TextEditingController controller = TextEditingController(text: _sendAmount.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Amount ($_fromCurrency)'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: _fiatFlags[_fromCurrency]! + ' ',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _sendAmount = double.tryParse(controller.text) ?? _sendAmount;
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showFromCurrencySelector() {
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
            const Text('Select Currency', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: _fiatRatesFromUSD.keys.map((currency) {
                  return ListTile(
                    onTap: () {
                      setState(() => _fromCurrency = currency);
                      Navigator.pop(context);
                    },
                    leading: Text(_fiatFlags[currency]!, style: const TextStyle(fontSize: 24)),
                    title: Text(currency, style: const TextStyle(fontWeight: FontWeight.w700)),
                    trailing: _fromCurrency == currency
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

  void _showToCurrencySelector() {
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
            const Text('Select Crypto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: _cryptoRatesInUSD.keys.map((crypto) {
                  return ListTile(
                    onTap: () {
                      setState(() => _toCurrency = crypto);
                      Navigator.pop(context);
                    },
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.token, size: 20, color: Colors.blueGrey),
                    ),
                    title: Text(crypto, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('1 $crypto ≈ \$${_cryptoRatesInUSD[crypto]}'),
                    trailing: _toCurrency == crypto
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

  void _processExchange() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 16),
              const Text('Exchange Successful!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text(
                'Exchanged ${_sendAmount.toStringAsFixed(2)} $_fromCurrency to ${_receiveAmount.toStringAsFixed(4)} $_toCurrency',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Done', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );
    });
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
              _buildConversionCard(),
              const SizedBox(height: 24),
              _buildExchangeButton(),
              const SizedBox(height: 32),
              _buildChartSection(),
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
        const Text(
          'Exchange',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.settings, size: 20, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildConversionCard() {
    return Stack(
      children: [
        Column(
          children: [
            // Top Card: To Send
            GestureDetector(
              onTap: _showAmountDialog,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'To send',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${_sendAmount.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: _showFromCurrencySelector,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F6FA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                 Text(_fromCurrency, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                 const SizedBox(width: 4),
                                 const Icon(Icons.keyboard_arrow_down, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                     const SizedBox(height: 8),
                     // Dynamic available balance mock
                     const Text('Available: \$8,182.80', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16), 
            // Bottom Card: Received
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Receive (Estimated)',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _receiveAmount.toStringAsFixed(4),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: _showToCurrencySelector,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6FA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                               const Icon(Icons.token, color: Colors.purple, size: 14),
                               const SizedBox(width: 4),
                               Text(_toCurrency, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                               const SizedBox(width: 4),
                               const Icon(Icons.keyboard_arrow_down, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 8),
                   Text(
                     '1 $_toCurrency ≈ \$${_cryptoRatesInUSD[_toCurrency]}', 
                     style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)
                   ),
                ],
              ),
            ),
          ],
        ),
        // Central Swap Button
        Positioned(
          top: 130, 
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF5F6FA), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.swap_vert, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExchangeButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _processExchange,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Sleek black button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
        child: const Text(
          'Exchange Now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
           BoxShadow(
            color: Colors.black.withOpacity(0.03),
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
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.token, color: Colors.purple, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _toCurrency == 'ETH' ? 'Ethereum' : _toCurrency,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _toCurrency,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${_cryptoRatesInUSD[_toCurrency]}',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    '+5.2%',
                    style: TextStyle(
                      color: Colors.green, // Positive change
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 3.5),
                      FlSpot(2, 3.2),
                      FlSpot(3, 4),
                      FlSpot(4, 3.8),
                      FlSpot(5, 5),
                      FlSpot(6, 4.8),
                      FlSpot(7, 6),
                    ],
                    isCurved: true,
                    color: AppColors.primaryBlue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primaryBlue.withOpacity(0.1), // Nice fade
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _ranges.map((range) => _buildRangeButton(range)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeButton(String text) {
    bool isSelected = _selectedRange == text;
    return GestureDetector(
      onTap: () => setState(() => _selectedRange = text),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
