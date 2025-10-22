import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/wallet.dart';
import '../design_system/app_colors.dart';
import '../utils/currency_converter.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;
  final VoidCallback? onTap;
  final String? displayCurrency;

  const WalletCard({
    super.key,
    required this.wallet,
    this.onTap,
    this.displayCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final targetCurrency = displayCurrency ?? wallet.currency;
    
    // Convert balance if needed
    double displayBalance = wallet.balance;
    if (wallet.currency != 'BTC' && targetCurrency != wallet.currency) {
      displayBalance = CurrencyConverter.convertBetween(
        wallet.balance,
        'USD', // Assuming wallet balance is in USD
        targetCurrency,
      );
    }
    
    final currencyFormat = NumberFormat.currency(
      symbol: wallet.currency == 'BTC' 
          ? '₿' 
          : CurrencyConverter.getSymbol(targetCurrency),
      decimalDigits: wallet.currency == 'BTC' ? 4 : 2,
    );

    LinearGradient gradient;
    switch (wallet.type) {
      case 'savings':
        gradient = AppColors.greenGradient;
        break;
      case 'crypto':
        gradient = AppColors.orangeGradient;
        break;
      default:
        gradient = AppColors.primaryGradient;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 16),
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    wallet.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (wallet.isPrimary)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Primary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balance',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currencyFormat.format(displayBalance),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
