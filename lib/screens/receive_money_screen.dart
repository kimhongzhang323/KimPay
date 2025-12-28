import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../design_system/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveMoneyScreen extends StatefulWidget {
  const ReceiveMoneyScreen({super.key});

  @override
  State<ReceiveMoneyScreen> createState() => _ReceiveMoneyScreenState();
}

class _ReceiveMoneyScreenState extends State<ReceiveMoneyScreen> {
  String _paymentMode = 'free'; // 'free' or 'fixed'
  final TextEditingController _amountController = TextEditingController();
  String _qrData = 'kimpay://pay?user=kimhong_goldboy&mode=free';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateQrCode() {
    setState(() {
      if (_paymentMode == 'free') {
        _qrData = 'kimpay://pay?user=kimhong_goldboy&mode=free';
      } else {
        final amount = _amountController.text.isNotEmpty 
            ? _amountController.text 
            : '0.00';
        _qrData = 'kimpay://pay?user=kimhong_goldboy&mode=fixed&amount=$amount';
      }
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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                children: [
                  // User Info Card
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
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6FA),
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/profile.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kim Hong Zhang',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'kimhongzhang323',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6FA),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.qr_code_2, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment Mode Selection
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
                                _paymentMode = 'free';
                                _updateQrCode();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _paymentMode == 'free' 
                                    ? Colors.black 
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Free Amount',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _paymentMode == 'free'
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
                                _paymentMode = 'fixed';
                                _updateQrCode();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _paymentMode == 'fixed' 
                                    ? Colors.black 
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Fixed Amount',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _paymentMode == 'fixed'
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
                  
                  // Fixed Amount Input
                  if (_paymentMode == 'fixed') ...[
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Set Amount',
                        hintText: '0.00',
                        prefixIcon: const Icon(Icons.attach_money, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) => _updateQrCode(),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // QR Code
                  Center(
                    child: Container(
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
                        children: [
                          QrImageView(
                            data: _qrData,
                            version: QrVersions.auto,
                            size: 200.0,
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          if (_paymentMode == 'fixed' && _amountController.text.isNotEmpty) ...[
                            Text(
                              '\$${_amountController.text}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          const Text(
                            'Scan to Pay',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Share Button
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            'Share QR Code',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
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
            'Receive Money',
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
}
