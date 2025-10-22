class Wallet {
  final String id;
  final String name;
  final String currency;
  final double balance;
  final String type;
  final bool isPrimary;

  Wallet({
    required this.id,
    required this.name,
    required this.currency,
    required this.balance,
    required this.type,
    this.isPrimary = false,
  });
}
