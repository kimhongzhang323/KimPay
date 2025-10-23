import 'package:flutter/material.dart';
import '../services/pin_service.dart';
import '../widgets/pin_input_widget.dart';

/// Screen for setting up a new 6-digit PIN
class PinSetupScreen extends StatefulWidget {
  final bool isChangingPin;
  final VoidCallback? onPinSetup;
  
  const PinSetupScreen({
    super.key,
    this.isChangingPin = false,
    this.onPinSetup,
  });

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final GlobalKey<State<PinInputWidget>> _pinInputKey = GlobalKey();
  final GlobalKey<State<PinInputWidget>> _confirmPinInputKey = GlobalKey();
  
  String? _enteredPin;
  bool _isConfirmStep = false;
  bool _isLoading = false;
  String? _errorMessage;
  
  void _handlePinEntry(String pin) {
    if (!_isConfirmStep) {
      // First step - save PIN and move to confirmation
      setState(() {
        _enteredPin = pin;
        _isConfirmStep = true;
        _errorMessage = null;
      });
    } else {
      // Second step - verify match
      _verifyAndSetPin(pin);
    }
  }
  
  Future<void> _verifyAndSetPin(String confirmPin) async {
    if (_enteredPin != confirmPin) {
      setState(() {
        _errorMessage = 'PINs do not match. Please try again.';
      });
      
      // Clear the confirm input
      (_confirmPinInputKey.currentState as dynamic)?.clear();
      
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    final success = await PinService.setPin(confirmPin);
    
    if (!mounted) return;
    
    if (success) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isChangingPin 
              ? 'PIN changed successfully!' 
              : 'PIN set up successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      
      // Callback or navigate back
      if (widget.onPinSetup != null) {
        widget.onPinSetup!();
      } else {
        Navigator.of(context).pop(true);
      }
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to set PIN. Please try again.';
      });
    }
  }
  
  void _goBack() {
    if (_isConfirmStep) {
      // Go back to first step
      setState(() {
        _isConfirmStep = false;
        _enteredPin = null;
        _errorMessage = null;
      });
      (_pinInputKey.currentState as dynamic)?.clear();
    } else {
      // Exit screen
      Navigator.of(context).pop();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _isLoading ? null : _goBack,
        ),
        title: Text(widget.isChangingPin ? 'Change PIN' : 'Set Up PIN'),
      ),
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
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: theme.colorScheme.primary,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                _isConfirmStep ? 'Confirm Your PIN' : 'Create Your PIN',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Description
              Text(
                _isConfirmStep
                    ? 'Enter your PIN again to confirm'
                    : 'Enter a 6-digit PIN to secure your wallet',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // PIN Input
              if (!_isConfirmStep)
                PinInputWidget(
                  key: _pinInputKey,
                  onCompleted: _handlePinEntry,
                  enabled: !_isLoading,
                  onChanged: () {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                  },
                )
              else
                PinInputWidget(
                  key: _confirmPinInputKey,
                  onCompleted: _handlePinEntry,
                  enabled: !_isLoading,
                  onChanged: () {
                    if (_errorMessage != null) {
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
              
              const Spacer(flex: 2),
              
              // Tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Choose a PIN that is easy to remember but hard for others to guess.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
