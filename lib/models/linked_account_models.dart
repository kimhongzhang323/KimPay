class LinkedAccount {
  final String id;
  final String name;
  final String accountType;
  final String accountNumber;
  final double balance;
  final String currency;
  final bool isVerified;
  DateTime lastSynced;

  LinkedAccount({
    required this.id,
    required this.name,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.isVerified,
    required this.lastSynced,
  });
}

class AvailableAccount {
  final String id;
  final String name;
  final String accountType;
  final String description;

  AvailableAccount({
    required this.id,
    required this.name,
    required this.accountType,
    required this.description,
  });
}
