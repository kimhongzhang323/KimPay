import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/wallet.dart';
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
    List<Color> patternColors;
    String cardPattern;
    
    switch (wallet.type) {
      case 'savings':
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00BCD4), Color(0xFF00838F)],
        );
        patternColors = [Color(0xFF00ACC1), Color(0xFF006064)];
        cardPattern = 'savings';
        break;
      case 'crypto':
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
        );
        patternColors = [Color(0xFF1976D2), Color(0xFF01579B)];
        cardPattern = 'crypto';
        break;
      default:
        gradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
        );
        patternColors = [Color(0xFF1E88E5), Color(0xFF1565C0)];
        cardPattern = 'default';
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
              color: Colors.black.withOpacity(0.15),
              blurRadius: 25,
              offset: const Offset(0, 12),
              spreadRadius: -5,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Realistic card pattern overlay
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CustomPaint(
                  painter: _CardPatternPainter(
                    patternType: cardPattern,
                    patternColors: patternColors,
                  ),
                ),
              ),
            ),
            // Glossy overlay effect
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Card content
            Padding(
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
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      if (wallet.isPrimary)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
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
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
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
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for realistic card patterns
class _CardPatternPainter extends CustomPainter {
  final String patternType;
  final List<Color> patternColors;

  _CardPatternPainter({
    required this.patternType,
    required this.patternColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    switch (patternType) {
      case 'savings':
        // Diagonal wave pattern for savings
        _paintWavePattern(canvas, size, paint);
        break;
      case 'crypto':
        // Hexagon mesh pattern for crypto
        _paintHexagonPattern(canvas, size, paint);
        break;
      default:
        // Circular gradient dots for default
        _paintCirclePattern(canvas, size, paint);
    }
  }

  void _paintWavePattern(Canvas canvas, Size size, Paint paint) {
    paint.color = patternColors[0].withOpacity(0.15);
    
    final path = Path();
    for (var i = 0; i < 3; i++) {
      path.reset();
      final offset = i * 60.0;
      path.moveTo(-size.width * 0.2, size.height * 0.5 + offset);
      
      for (var x = -size.width * 0.2; x <= size.width * 1.2; x += 40) {
        final y = size.height * 0.5 + offset + (i % 2 == 0 ? -20 : 20) * 
                  (1 + 0.5 * ((x / 40) % 2));
        path.lineTo(x, y);
      }
      
      path.lineTo(size.width * 1.2, size.height);
      path.lineTo(-size.width * 0.2, size.height);
      path.close();
      
      canvas.drawPath(path, paint);
    }
  }

  void _paintHexagonPattern(Canvas canvas, Size size, Paint paint) {
    paint.color = patternColors[0].withOpacity(0.12);
    paint.strokeWidth = 1.5;
    paint.style = PaintingStyle.stroke;

    const hexSize = 30.0;
    final horizontalSpacing = hexSize * 1.5;
    final verticalSpacing = hexSize * 0.866 * 2;

    for (var row = -2; row < (size.height / verticalSpacing) + 2; row++) {
      for (var col = -2; col < (size.width / horizontalSpacing) + 2; col++) {
        final x = col * horizontalSpacing + (row % 2 == 0 ? 0 : horizontalSpacing / 2);
        final y = row * verticalSpacing;
        
        _drawHexagon(canvas, Offset(x, y), hexSize, paint);
      }
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = (60 * i - 30) * (3.14159 / 180);
      final x = center.dx + size * cos(angle);
      final y = center.dy + size * sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double sin(double radians) {
    // Taylor series approximation for sin
    double x = radians;
    double sum = x;
    double term = x;
    for (int n = 1; n < 10; n++) {
      term *= -x * x / ((2 * n) * (2 * n + 1));
      sum += term;
    }
    return sum;
  }

  double cos(double radians) {
    // Taylor series approximation for cos
    double x = radians;
    double sum = 1.0;
    double term = 1.0;
    for (int n = 1; n < 10; n++) {
      term *= -x * x / ((2 * n - 1) * (2 * n));
      sum += term;
    }
    return sum;
  }

  void _paintCirclePattern(Canvas canvas, Size size, Paint paint) {
    paint.color = patternColors[0].withOpacity(0.1);
    paint.style = PaintingStyle.fill;

    final random = _SeededRandom(42); // Consistent pattern
    
    for (var i = 0; i < 15; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 20 + random.nextDouble() * 40;
      
      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint..color = patternColors[i % 2].withOpacity(0.08),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple seeded random for consistent patterns
class _SeededRandom {
  int _seed;

  _SeededRandom(this._seed);

  double nextDouble() {
    _seed = ((_seed * 1103515245 + 12345) & 0x7fffffff);
    return _seed / 0x7fffffff;
  }
}
