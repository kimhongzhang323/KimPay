import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../design_system/app_colors.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  
  String _inputType = 'phone'; // 'phone' or 'account'
  String _platform = 'KimPay'; // KimPay, Touch n Go, Boost, GrabPay, etc.
  
  // Mock data - in real app, this would come from API
  String? _recipientName;
  double? _trustScore;
  String? _aiAdvice;
  bool _isLoading = false;
  
  final double _totalBalance = 8750.50; // Mock total balance
  double _remainingBalance = 8750.50;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_calculateRemainingBalance);
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _calculateRemainingBalance() {
    setState(() {
      final amount = double.tryParse(_amountController.text) ?? 0.0;
      _remainingBalance = _totalBalance - amount;
    });
  }

  Future<void> _lookupRecipient(String value) async {
    if (value.isEmpty) {
      setState(() {
        _recipientName = null;
        _trustScore = null;
        _aiAdvice = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock recipient data based on input
    setState(() {
      if (_inputType == 'phone') {
        if (value.length >= 10) {
          _recipientName = 'Sarah Lee';
          _trustScore = 92.5;
          _aiAdvice = 'High trust score. Regular contact. Safe to transfer.';
        }
      } else {
        if (value.length >= 10) {
          _recipientName = 'Tech Solutions Sdn Bhd';
          _trustScore = 78.0;
          _aiAdvice = 'Verified merchant. Check invoice details before transfer.';
        }
      }
      _isLoading = false;
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
                    // Available Balance Card
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
                                'Available Balance',
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
                            '\$${_totalBalance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          if (_amountController.text.isNotEmpty && 
                              double.tryParse(_amountController.text) != null) ...[
                            const SizedBox(height: 16),
                            const Divider(height: 32, thickness: 1, color: Color(0xFFF5F6FA)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'After Transfer',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '\$${_remainingBalance.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: _remainingBalance < 0 
                                        ? AppColors.accentRed 
                                        : AppColors.textPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Platform Selection
                    const Text(
                      'Transfer To',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _PlatformChip(
                            label: 'KimPay',
                            isSelected: _platform == 'KimPay',
                            onTap: () => setState(() => _platform = 'KimPay'),
                          ),
                          _PlatformChip(
                            label: 'Touch n Go',
                            isSelected: _platform == 'Touch n Go',
                            onTap: () => setState(() => _platform = 'Touch n Go'),
                          ),
                          _PlatformChip(
                            label: 'Boost',
                            isSelected: _platform == 'Boost',
                            onTap: () => setState(() => _platform = 'Boost'),
                          ),
                          _PlatformChip(
                            label: 'GrabPay',
                            isSelected: _platform == 'GrabPay',
                            onTap: () => setState(() => _platform = 'GrabPay'),
                          ),
                          _PlatformChip(
                            label: 'Bank Transfer',
                            isSelected: _platform == 'Bank Transfer',
                            onTap: () => setState(() => _platform = 'Bank Transfer'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Input Type Toggle
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _inputType = 'phone';
                                  _recipientController.clear();
                                  _recipientName = null;
                                  _trustScore = null;
                                  _aiAdvice = null;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _inputType == 'phone' 
                                      ? Colors.black 
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Phone Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: _inputType == 'phone' 
                                        ? FontWeight.w700 
                                        : FontWeight.w500,
                                    color: _inputType == 'phone'
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _inputType = 'account';
                                  _recipientController.clear();
                                  _recipientName = null;
                                  _trustScore = null;
                                  _aiAdvice = null;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _inputType == 'account' 
                                      ? Colors.black 
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Account Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: _inputType == 'account' 
                                        ? FontWeight.w700 
                                        : FontWeight.w500,
                                    color: _inputType == 'account'
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Recipient Input
                    TextFormField(
                      controller: _recipientController,
                      keyboardType: _inputType == 'phone' 
                          ? TextInputType.phone 
                          : TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: _inputType == 'phone' 
                            ? 'Recipient Phone Number' 
                            : 'Recipient Account Number',
                        hintText: _inputType == 'phone' ? '0123456789' : '1234567890',
                        prefixIcon: Icon(
                          _inputType == 'phone' ? Icons.phone : Icons.account_balance,
                          color: AppColors.textSecondary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: _lookupRecipient,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ${_inputType == 'phone' ? 'phone number' : 'account number'}';
                        }
                        return null;
                      },
                    ),
                    
                    // Recipient Info Card (shown after lookup)
                    if (_isLoading) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      ),
                    ] else if (_recipientName != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.accentGreen.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentGreen.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentGreen.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.accentGreen,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Recipient',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _recipientName!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 1, color: Color(0xFFF5F6FA)),
                            const SizedBox(height: 16),
                            
                            // Trust Score
                            Row(
                              children: [
                                const Icon(
                                  Icons.verified_user,
                                  color: AppColors.textPrimary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Trust Score:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5F6FA),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      FractionallySizedBox(
                                        widthFactor: (_trustScore ?? 0) / 100,
                                        child: Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: AppColors.accentGreen,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${_trustScore?.toStringAsFixed(1)}%',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.accentGreen,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            // AI Advice
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F6FA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.auto_awesome,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _aiAdvice ?? '',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w500,
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
                    
                    const SizedBox(height: 24),
                    
                    // Amount Input
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: '0.00',
                        prefixIcon: const Icon(
                          Icons.attach_money,
                          color: AppColors.textSecondary,
                        ),
                        prefixText: '\$ ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Note (Optional)
                    TextFormField(
                      controller: _noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Note (Optional)',
                        hintText: 'Add a note for this transfer',
                        prefixIcon: const Icon(
                          Icons.note,
                          color: AppColors.textSecondary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Transfer Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _recipientName == null
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _showConfirmationDialog();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          disabledBackgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Transfer Now',
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
            'Transfer Money',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 40), // Balance spacing
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    // ... (Use existing confirmation dialog method or simplified one)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transfer Sent'),
        content: const Text('Money has been transferred successfully.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }
}

class _PlatformChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlatformChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[200]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
