import '../models/wallet.dart';
import '../models/transaction.dart';

class MockData {
  static List<Wallet> getWallets() {
    return [
      Wallet(
        id: '1',
        name: 'Main Wallet',
        currency: 'USD',
        balance: 2547.50,
        type: 'digital',
        isPrimary: true,
      ),
      Wallet(
        id: '2',
        name: 'Savings',
        currency: 'USD',
        balance: 12350.00,
        type: 'savings',
      ),
      Wallet(
        id: '3',
        name: 'Crypto Wallet',
        currency: 'BTC',
        balance: 0.0234,
        type: 'crypto',
      ),
    ];
  }

  static List<Transaction> getTransactions() {
    return [
      Transaction(
        id: '1',
        type: 'sent',
        title: 'Transfer to John',
        subtitle: 'Lunch payment',
        amount: -45.00,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'completed',
        icon: '👤',
      ),
      Transaction(
        id: '2',
        type: 'received',
        title: 'Received from Sarah',
        subtitle: 'Shared expenses',
        amount: 120.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: 'completed',
        icon: '👤',
      ),
      Transaction(
        id: '3',
        type: 'payment',
        title: 'Starbucks',
        subtitle: 'Coffee & snacks',
        amount: -8.50,
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: 'completed',
        icon: '☕',
      ),
      Transaction(
        id: '4',
        type: 'topup',
        title: 'Wallet Top-up',
        subtitle: 'Bank transfer',
        amount: 500.00,
        date: DateTime.now().subtract(const Duration(days: 3)),
        status: 'completed',
        icon: '💳',
      ),
      Transaction(
        id: '5',
        type: 'payment',
        title: 'Uber Ride',
        subtitle: 'To downtown',
        amount: -18.75,
        date: DateTime.now().subtract(const Duration(days: 4)),
        status: 'completed',
        icon: '🚗',
      ),
    ];
  }

  static Map<String, dynamic> getBudgetInsights() {
    return {
      'monthlySpending': 1247.50,
      'monthlyBudget': 2000.00,
      'categories': [
        {'name': 'Food & Dining', 'amount': 456.00, 'percentage': 36.5},
        {'name': 'Transportation', 'amount': 234.50, 'percentage': 18.8},
        {'name': 'Shopping', 'amount': 312.00, 'percentage': 25.0},
        {'name': 'Entertainment', 'amount': 245.00, 'percentage': 19.7},
      ],
      'predictions': [
        'You\'re on track to save \$750 this month',
        'Transportation spending is 15% lower than last month',
        'Consider setting a budget for Shopping category',
      ],
    };
  }
}
