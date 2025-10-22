import '../models/linked_account_models.dart';

class LinkedAccountsData {
  static List<LinkedAccount> getLinkedAccounts() {
    return [
      LinkedAccount(
        id: '1',
        name: 'HSBC Savings',
        accountType: 'bank',
        accountNumber: '****1234',
        balance: 15420.50,
        currency: 'USD',
        isVerified: true,
        lastSynced: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      LinkedAccount(
        id: '2',
        name: 'Touch \'n Go eWallet',
        accountType: 'touchngo',
        accountNumber: '****5678',
        balance: 234.80,
        currency: 'MYR',
        isVerified: true,
        lastSynced: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      LinkedAccount(
        id: '3',
        name: 'Boost Wallet',
        accountType: 'boost',
        accountNumber: '****9012',
        balance: 156.20,
        currency: 'MYR',
        isVerified: true,
        lastSynced: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      LinkedAccount(
        id: '4',
        name: 'Alipay',
        accountType: 'alipay',
        accountNumber: '****3456',
        balance: 1250.00,
        currency: 'CNY',
        isVerified: true,
        lastSynced: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];
  }

  static List<AvailableAccount> getAvailableAccounts() {
    return [
      AvailableAccount(
        id: 'paypal',
        name: 'PayPal',
        accountType: 'paypal',
        description: 'Link your PayPal account',
      ),
      AvailableAccount(
        id: 'wechat',
        name: 'WeChat Pay',
        accountType: 'wechat',
        description: 'Connect WeChat wallet',
      ),
      AvailableAccount(
        id: 'bank',
        name: 'Bank Account',
        accountType: 'bank',
        description: 'Add another bank account',
      ),
    ];
  }

  static double getTotalBalance() {
    return getLinkedAccounts()
        .fold(0.0, (sum, account) => sum + account.balance);
  }
}
