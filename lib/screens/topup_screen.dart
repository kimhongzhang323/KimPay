import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../design_system/app_colors.dart';

class TopUpScreen extends StatefulWidget {
  final String paymentMethod;

  const TopUpScreen({
    super.key,
    required this.paymentMethod,
  });

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  
  final double _currentBalance = 8750.50;
  
  // Quick Amounts
  final List<double> _quickAmounts = [10, 50, 100, 500, 1000, 5000];
  double? _selectedQuickAmount;

  // Funding Source State
  String _selectedSource = 'Maybank';
  String? _selectedSourceImage; // Null for icon, path for image
  String _selectedSourceDetail = '•••• 8888';

  @override
  void initState() {
    super.initState();
    // Default to bank transfer if passed, otherwise default is set above
    if (widget.paymentMethod != 'Bank Transfer') {
      // Logic to map widget.paymentMethod to initial state could go here
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _selectQuickAmount(double amount) {
    setState(() {
      _selectedQuickAmount = amount;
      _amountController.text = amount.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  children: [
                    // Curent Balance Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
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
                              const Text(
                                'Current Balance',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF5F6FA),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.account_balance_wallet, size: 16, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '\$${_currentBalance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Funding Source Selector
                    const Text(
                      'Top Up From',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _showSourceSelection,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.transparent),
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
                              width: 48,
                              height: 48,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F6FA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _selectedSourceImage != null
                                  ? Image.asset(_selectedSourceImage!)
                                  : const Icon(Icons.account_balance, color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedSource,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _selectedSourceDetail,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Quick Amount Selection
                    const Text(
                      'Quick Top Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.0,
                      ),
                      itemCount: _quickAmounts.length,
                      itemBuilder: (context, index) {
                        final amount = _quickAmounts[index];
                        final isSelected = _selectedQuickAmount == amount;
                        
                        return GestureDetector(
                          onTap: () => _selectQuickAmount(amount),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? Colors.transparent : Colors.transparent,
                              ),
                              boxShadow: [
                                if (!isSelected)
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '\$${amount.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    // Custom Amount Input
                    const Text(
                      'Or Enter Custom Amount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: '0.00',
                        prefixIcon: const Icon(Icons.attach_money, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedQuickAmount = null;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Confirm Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _processTopUp();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Top Up Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           GestureDetector(
             onTap: () => Navigator.pop(context),
             child: Container(
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
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            ),
          ),
          const Text(
            'Top Up',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  void _showSourceSelection() {
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
              'Select Source',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 400, // Limit height
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildSourceOption('Maybank', '•••• 8888', null),
                  _buildSourceOption('CIMB Bank', '•••• 1234', null),
                  _buildSourceOption('Touch \'n Go', 'eWallet', 'assets/images/touchngo.png'),
                  _buildSourceOption('GrabPay', 'eWallet', 'assets/images/grab.png'),
                  _buildSourceOption('Boost', 'eWallet', 'assets/images/boost.png'),
                  _buildSourceOption('PayPal', 'user@email.com', 'assets/images/paypal.png'),
                  _buildSourceOption('AliPay', 'eWallet', 'assets/images/alipay.png'),
                  _buildSourceOption('WeChat Pay', 'eWallet', 'assets/images/wechatpay.png'),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption(String name, String detail, String? imagePath) {
    return ListTile(
      onTap: () {
        setState(() {
          _selectedSource = name;
          _selectedSourceDetail = detail;
          _selectedSourceImage = imagePath;
        });
        Navigator.pop(context);
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: imagePath != null
            ? Image.asset(imagePath)
            : const Icon(Icons.account_balance, color: Colors.black),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(detail),
      trailing: _selectedSource == name
          ? const Icon(Icons.check_circle, color: AppColors.primaryBlue)
          : null,
    );
  }

  void _processTopUp() async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );

    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pop(context); // Remove loading

    // Show success
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.accentGreen, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Top Up Successful!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Amount \$${_amountController.text} added via $_selectedSource.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
               style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              child: const Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
