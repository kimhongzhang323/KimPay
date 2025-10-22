class CurrencyConverter {
  // Exchange rates relative to USD (as of Oct 2025)
  static const Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'EUR': 0.92,
    'GBP': 0.79,
    'JPY': 149.50,
    'CNY': 7.24,
    'MYR': 4.68,
    'SGD': 1.35,
    'AUD': 1.52,
  };

  static const Map<String, String> _currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'CNY': '¥',
    'MYR': 'RM',
    'SGD': 'S\$',
    'AUD': 'A\$',
  };

  // Convert from USD to target currency
  static double convert(double amountInUSD, String targetCurrency) {
    final rate = _exchangeRates[targetCurrency] ?? 1.0;
    return amountInUSD * rate;
  }

  // Convert from any currency to another
  static double convertBetween(
    double amount,
    String fromCurrency,
    String toCurrency,
  ) {
    // First convert to USD
    final fromRate = _exchangeRates[fromCurrency] ?? 1.0;
    final amountInUSD = amount / fromRate;
    
    // Then convert to target currency
    return convert(amountInUSD, toCurrency);
  }

  // Get currency symbol
  static String getSymbol(String currency) {
    return _currencySymbols[currency] ?? '\$';
  }

  // Format amount with currency
  static String format(double amount, String currency, {int decimals = 2}) {
    final symbol = getSymbol(currency);
    final formattedAmount = amount.toStringAsFixed(decimals);
    
    // For currencies that use symbol after (none in our list, but for extensibility)
    return '$symbol$formattedAmount';
  }

  // Get all available currencies
  static List<String> getAvailableCurrencies() {
    return _exchangeRates.keys.toList();
  }

  // Get exchange rate for display
  static String getExchangeRate(String fromCurrency, String toCurrency) {
    final rate = convertBetween(1.0, fromCurrency, toCurrency);
    return '1 $fromCurrency = ${rate.toStringAsFixed(4)} $toCurrency';
  }
}
