class Transaction {
  final String id;
  final String type;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final String status;
  final String? icon;

  Transaction({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.status,
    this.icon,
  });
}
