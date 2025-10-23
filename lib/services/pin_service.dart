import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Service to manage PIN code storage and validation
class PinService {
  static const String _pinKey = 'user_pin_hash';
  static const String _pinSetKey = 'pin_is_set';
  
  /// Check if PIN has been set up
  static Future<bool> isPinSet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_pinSetKey) ?? false;
  }
  
  /// Hash the PIN for secure storage
  static String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }
  
  /// Set up a new PIN
  static Future<bool> setPin(String pin) async {
    if (pin.length != 6 || !_isNumeric(pin)) {
      return false;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final hashedPin = _hashPin(pin);
      
      await prefs.setString(_pinKey, hashedPin);
      await prefs.setBool(_pinSetKey, true);
      
      return true;
    } catch (e) {
      debugPrint('Error setting PIN: $e');
      return false;
    }
  }
  
  /// Verify if the entered PIN is correct
  static Future<bool> verifyPin(String pin) async {
    if (pin.length != 6 || !_isNumeric(pin)) {
      return false;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedHash = prefs.getString(_pinKey);
      
      if (storedHash == null) {
        return false;
      }
      
      final enteredHash = _hashPin(pin);
      return storedHash == enteredHash;
    } catch (e) {
      debugPrint('Error verifying PIN: $e');
      return false;
    }
  }
  
  /// Change existing PIN (requires old PIN verification)
  static Future<bool> changePin(String oldPin, String newPin) async {
    final isOldPinValid = await verifyPin(oldPin);
    
    if (!isOldPinValid) {
      return false;
    }
    
    return await setPin(newPin);
  }
  
  /// Reset PIN (use with caution - should require additional authentication)
  static Future<bool> resetPin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pinKey);
      await prefs.setBool(_pinSetKey, false);
      return true;
    } catch (e) {
      debugPrint('Error resetting PIN: $e');
      return false;
    }
  }
  
  /// Check if string contains only digits
  static bool _isNumeric(String str) {
    return RegExp(r'^[0-9]+$').hasMatch(str);
  }
}
