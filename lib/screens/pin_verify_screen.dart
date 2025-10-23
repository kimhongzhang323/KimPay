import 'package:flutter/material.dart';
import '../services/pin_service.dart';
import '../widgets/pin_input_widget.dart';

/// Screen for verifying the user's PIN
class PinVerifyScreen extends StatefulWidget {
  final VoidCallback? onSuccess;
  final bool canGoBack;
  final int maxAttempts;
  
  const PinVerifyScreen({
    super.key,
    this.onSuccess,
    this.canGoBack = false,
    this.maxAttempts = 5,
  });

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  final GlobalKey<State<PinInputWidget>> _pinInputKey = GlobalKey();
  
  bool _isLoading = false;
  String? _errorMessage;
  int _attemptCount = 0;
  bool _isLocked = false;
  
  Future<void> _handlePinEntry(String pin) async {
    if (_isLocked) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    final isValid = await PinService.verifyPin(pin);
    
    if (!mounted) return;
    
    if (isValid) {
      // PIN is correct
      setState(() {
        _isLoading = false;
      });
      
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      } else {
        Navigator.of(context).pop(true);
      }
    } else {
      // PIN is incorrect
      setState(() {
        _attemptCount++;
        _isLoading = false;
        
        if (_attemptCount >= widget.maxAttempts) {
          _isLocked = true;
          _errorMessage = 'Too many failed attempts. Please try again later.';
        } else {
          final remainingAttempts = widget.maxAttempts - _attemptCount;
          _errorMessage = 'Incorrect PIN. $remainingAttempts ${remainingAttempts == 1 ? "attempt" : "attempts"} remaining.';
        }
      });
      
      // Clear input
      (_pinInputKey.currentState as dynamic)?.clear();
    }
  }
  
  void _handleForgotPin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot PIN?'),
        content: const Text(
          'To reset your PIN, you will need to log in again with your credentials.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navigate to login or reset flow
              // For now, just go back
              if (widget.canGoBack) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: widget.canGoBack
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
              ),
              title: const Text('Enter PIN'),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              
              // Lock icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _isLocked
                      ? theme.colorScheme.errorContainer
                      : theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isLocked ? Icons.lock : Icons.lock_outline,
                  size: 64,
                  color: _isLocked
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                _isLocked ? 'Account Locked' : 'Enter Your PIN',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Description
              Text(
                _isLocked
                    ? 'Too many failed attempts'
                    : 'Enter your 6-digit PIN to access your wallet',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // PIN Input
              PinInputWidget(
                key: _pinInputKey,
                onCompleted: _handlePinEntry,
                enabled: !_isLoading && !_isLocked,
                onChanged: () {
                  if (_errorMessage != null && !_isLocked) {
                    setState(() => _errorMessage = null);
                  }
                },
              ),
              
              const SizedBox(height: 24),
              
              // Error message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: theme.colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Loading indicator
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: CircularProgressIndicator(),
                ),
              
              const SizedBox(height: 24),
              
              // Forgot PIN button
              if (!_isLocked)
                TextButton(
                  onPressed: _isLoading ? null : _handleForgotPin,
                  child: const Text('Forgot PIN?'),
                ),
              
              const Spacer(flex: 2),
              
              // Attempt counter (when not locked)
              if (!_isLocked && _attemptCount > 0)
                Text(
                  'Attempts: $_attemptCount/${widget.maxAttempts}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
