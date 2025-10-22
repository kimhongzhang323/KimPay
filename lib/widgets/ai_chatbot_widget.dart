import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';

class AIChatbotWidget extends StatefulWidget {
  final String programType;

  const AIChatbotWidget({
    super.key,
    required this.programType,
  });

  @override
  State<AIChatbotWidget> createState() => _AIChatbotWidgetState();
}

class _AIChatbotWidgetState extends State<AIChatbotWidget> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    // Add welcome message
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: _getWelcomeMessage(),
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String _getWelcomeMessage() {
    switch (widget.programType) {
      case 'shop':
        return 'Hi! 👋 I\'m your shopping assistant. I can help you find products, compare prices across Shopee, Lazada, and Taobao, or answer any questions!';
      case 'ride':
        return 'Hello! 🚗 I\'m here to help you book rides from Grab, Uber, Bolt, and more. Need a ride or have questions?';
      case 'food':
        return 'Hey there! 🍔 Hungry? I can help you find restaurants, check delivery times, or recommend dishes!';
      case 'movies':
        return 'Hi! 🎬 Ready for a movie? I can help you find showtimes, book tickets, or recommend films!';
      case 'mobile':
        return 'Hello! 📱 Need a mobile recharge? I\'m here to help with any questions!';
      case 'hotels':
        return 'Hi! 🏨 Looking for a place to stay? I can search hotels from Booking.com, Agoda, Traveloka, and more!';
      case 'flights':
        return 'Hello! ✈️ Planning a trip? I can help you find the best flight deals!';
      default:
        return 'Hi! 👋 How can I help you today?';
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: _messageController.text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    final userMessage = _messageController.text.toLowerCase();
    _messageController.clear();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: _generateResponse(userMessage),
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
      }
    });
  }

  String _generateResponse(String userMessage) {
    switch (widget.programType) {
      case 'shop':
        if (userMessage.contains('price') || userMessage.contains('compare') || userMessage.contains('cheap')) {
          return '🤖 AI Price Analysis:\n\n✅ Taobao: Usually 20-30% cheaper\n✅ Lazada: Good for local shipping\n✅ Shopee: Daily flash sales\n\nUse the "AI Find Best Price" button above for instant smart selection! 🛍️';
        } else if (userMessage.contains('shopee') || userMessage.contains('lazada') || userMessage.contains('taobao')) {
          return 'Great choice! That platform has some amazing deals. I can also auto-select the cheapest option for you using AI analysis. Just tap the purple button!';
        } else if (userMessage.contains('help') || userMessage.contains('ai')) {
          return 'I\'m your AI shopping assistant! 🤖 I can:\n\n✨ Compare prices across platforms\n✨ Find the cheapest deals instantly\n✨ Recommend best products\n\nTry asking about prices or tap "AI Find Best Price"!';
        }
        return 'I\'m here to help you save money! Ask me about prices, or use the AI button to instantly find the cheapest platform. What are you shopping for today?';
      
      case 'ride':
        if (userMessage.contains('price') || userMessage.contains('cost') || userMessage.contains('cheap')) {
          return '🤖 AI Ride Analysis:\n\n✅ InDrive: Usually cheapest (negotiate price)\n✅ Bolt: Competitive rates\n✅ Grab: Most reliable\n✅ Uber: Premium quality\n\nUse "AI Find Cheapest Ride" button for automatic selection! 🚗';
        } else if (userMessage.contains('grab') || userMessage.contains('uber') || userMessage.contains('bolt') || userMessage.contains('indrive')) {
          return 'Good choice! That service is available in your area. I can also compare prices across all platforms using AI. Try the purple button above!';
        } else if (userMessage.contains('help') || userMessage.contains('ai')) {
          return 'I\'m your AI ride assistant! 🤖 I can:\n\n✨ Compare ride prices\n✨ Find fastest arrival times\n✨ Select cheapest service\n\nAsk about prices or use the AI button!';
        }
        return 'I can help you find the best ride option! Just let me know your destination, and I\'ll use AI to compare prices across all platforms instantly!';
      
      case 'food':
        if (userMessage.contains('recommend') || userMessage.contains('suggest')) {
          return 'Based on popular orders in your area, I\'d recommend trying the local favorites! Would you like to see highly-rated restaurants nearby? 🍔';
        } else if (userMessage.contains('delivery') || userMessage.contains('time') || userMessage.contains('fast')) {
          return 'Delivery times vary by restaurant. Most places deliver within 20-30 minutes. I can help you find the fastest delivery options!';
        } else if (userMessage.contains('cheap') || userMessage.contains('price') || userMessage.contains('compare')) {
          return '🤖 AI Delivery Analysis:\n\n✅ GrabFood: Lowest fees usually\n✅ Foodpanda: More restaurant choices\n✅ Deliveroo: Premium restaurants\n✅ Shopeefood: Best deals\n\nUse "AI Find Best Delivery" for smart selection! 🍕';
        } else if (userMessage.contains('help') || userMessage.contains('ai')) {
          return 'I\'m your AI food assistant! 🤖 I can:\n\n✨ Compare delivery fees\n✨ Find fastest delivery\n✨ Recommend restaurants\n\nAsk about prices or tap the AI button!';
        }
        return 'I can help you find great food! What type of cuisine are you craving today? I can also compare delivery services for you!';
      
      case 'hotels':
        if (userMessage.contains('price') || userMessage.contains('compare') || userMessage.contains('cheap')) {
          return '🤖 AI Hotel Analysis:\n\n✅ Booking.com: Best overall prices\n✅ Agoda: Asia deals expert\n✅ Traveloka: Local hotels\n✅ Hotels.com: Loyalty rewards\n\nUse "AI Find Best Hotel Deal" for instant comparison! 🏨';
        } else if (userMessage.contains('booking') || userMessage.contains('agoda') || userMessage.contains('traveloka')) {
          return 'Excellent choice! That platform often has great hotel deals. Let me help you find the perfect stay! I can also auto-compare all platforms.';
        } else if (userMessage.contains('help') || userMessage.contains('ai')) {
          return 'I\'m your AI hotel assistant! 🤖 I can:\n\n✨ Compare hotel prices\n✨ Find best booking deals\n✨ Check amenities\n\nAsk about prices or use the AI button!';
        }
        return 'Looking for accommodation? I can use AI to compare prices across multiple platforms and find you the best hotel deals instantly!';
      
      case 'flights':
        if (userMessage.contains('cheap') || userMessage.contains('price')) {
          return 'I can help you find the best flight deals! What\'s your destination and travel dates? ✈️';
        } else if (userMessage.contains('when') || userMessage.contains('date')) {
          return 'Pro tip: Flights on Tuesdays and Wednesdays are often cheaper! When are you planning to travel?';
        }
        return 'I\'m here to help you find the perfect flight! Where would you like to go?';
      
      default:
        return 'I\'m here to help! Feel free to ask me anything about this service. 😊';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: _isExpanded ? MediaQuery.of(context).size.width - 32 : 60,
        height: _isExpanded ? 400 : 60,
        child: _isExpanded ? _buildExpandedChat() : _buildCollapsedButton(),
      ),
    );
  }

  Widget _buildCollapsedButton() {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.accentPurple,
              AppColors.primaryBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.smart_toy,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedChat() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accentPurple,
                  AppColors.primaryBlue,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.smart_toy,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Assistant',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Online',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _toggleExpanded,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          // Input
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                top: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentPurple,
                          AppColors.primaryBlue,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          gradient: message.isUser
              ? LinearGradient(
                  colors: [
                    AppColors.primaryBlue,
                    AppColors.accentPurple,
                  ],
                )
              : null,
          color: message.isUser ? null : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 16),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
