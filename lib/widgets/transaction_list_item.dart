import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../design_system/app_colors.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat('MMM dd, HH:mm');

    Color amountColor;
    IconData statusIcon;
    
    switch (transaction.type) {
      case 'received':
      case 'topup':
        amountColor = AppColors.accentGreen;
        statusIcon = Icons.arrow_downward;
        break;
      case 'sent':
      case 'payment':
        amountColor = AppColors.accentRed;
        statusIcon = Icons.arrow_upward;
        break;
      default:
        amountColor = AppColors.textPrimary;
        statusIcon = Icons.swap_horiz;
    }

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: amountColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: transaction.icon != null
              ? Text(
                  transaction.icon!,
                  style: const TextStyle(fontSize: 24),
                )
              : Icon(
                  statusIcon,
                  color: amountColor,
                  size: 24,
                ),
        ),
      ),
      title: Text(
        transaction.title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${transaction.subtitle} • ${dateFormat.format(transaction.date)}',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Text(
        '${transaction.amount > 0 ? '+' : ''}${currencyFormat.format(transaction.amount)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: amountColor,
        ),
      ),
    );
  }
}
