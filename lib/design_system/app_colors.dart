import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Enhanced Vibrant Palette (Increased Saturation)
  static const Color primaryBlue = Color(0xFF2196F3);        // #2196F3 - Material Blue (high saturation)
  static const Color primaryDark = Color(0xFF1565C0);        // #1565C0 - Deep Blue (rich, saturated)
  static const Color primaryLight = Color(0xFF64B5F6);       // #64B5F6 - Light Blue (vibrant)
  static const Color darkSlate = Color(0xFF0D47A1);          // #0D47A1 - Navy Blue (deep, saturated)
  
  // Accent Colors - Boosted vibrancy
  static const Color accentBlue = Color(0xFF2196F3);         // Vibrant blue
  static const Color accentDarkBlue = Color(0xFF1565C0);     // Rich darker variant
  static const Color accentLightBlue = Color(0xFF90CAF9);    // Brighter light variant
  static const Color accentTeal = Color(0xFF00BCD4);         // Cyan/Teal - vibrant (no purple)
  
  // Status Colors - More saturated and visible
  static const Color accentGreen = Color(0xFF4CAF50);        // Material green
  static const Color accentRed = Color(0xFFF44336);          // Material red
  static const Color accentOrange = Color(0xFFFF9800);       // Material orange
  static const Color accentPurple = Color(0xFF00BCD4);       // REPLACED: Using cyan instead of purple
  
  // Neutral Colors - Crisper, cleaner neutrals
  static const Color background = Color(0xFFF5F7FA);         // Clean light background
  static const Color surface = Color(0xFFFFFFFF);            // White
  static const Color surfaceVariant = Color(0xFFF8FAFB);     // Very light surface
  static const Color textPrimary = Color(0xFF212121);        // Dark text (high contrast)
  static const Color textSecondary = Color(0xFF546E7A);      // Blue-gray secondary text
  static const Color divider = Color(0xFFE0E0E0);            // Clear divider
  static const Color border = Color(0xFFBDBDBD);             // Visible border
  
  // Gradients - Vibrant blue-based gradients (NO PURPLE)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],         // Blue gradient
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],         // Deep blue gradient
  );
  
  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF64B5F6), Color(0xFF42A5F5)],         // Light blue gradient
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00BCD4), Color(0xFF00ACC1)],         // Cyan gradient (NOT purple)
  );
  
  // Legacy gradient names (mapped to new colors for compatibility)
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],         // Replaced with cyan (NO PURPLE)
  );
  
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA88F7D), Color(0xFF6A89A7)],
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6BA89F), Color(0xFF6A89A7)],
  );
  
  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1A384959);
  
  // Overlay Colors
  static Color overlayDark = const Color(0xFF384959).withOpacity(0.7);
  static Color overlayLight = const Color(0xFF88BDF2).withOpacity(0.1);
}
