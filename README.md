<div align="center">

# 💳 KimPay - Smart Payment Wallet

### Next-Generation Digital Wallet with AI-Powered Financial Intelligence

[![Flutter](https://img.shields.io/badge/Flutter-3.6.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Architecture](#-architecture) • [Contributing](#-contributing)

---

</div>

## 📋 Overview

**KimPay** is a comprehensive Flutter-based mobile payment wallet that revolutionizes personal finance management through AI-powered insights and seamless multi-currency support. Designed with a modern, intuitive interface, KimPay empowers users to manage their finances, track spending patterns, and make informed financial decisions with intelligent predictions and recommendations.

### Why KimPay?

- 🤖 **AI-Powered Intelligence**: Advanced machine learning algorithms analyze spending patterns and provide personalized financial insights
- 💱 **Multi-Currency Support**: Seamlessly manage multiple wallets across different currencies
- 📊 **Comprehensive Analytics**: Detailed visualizations and reports of income, expenses, and savings projections
- 🛍️ **Integrated Mini Programs**: Shop, order food, book rides, hotels, and flights directly within the app
- 🔒 **Secure Transactions**: Industry-standard security protocols to protect your financial data
- 🎨 **Modern UI/UX**: Beautiful, Material 3 design with smooth animations and intuitive navigation

---

## ✨ Features

### 💰 Core Wallet Management
- **Multi-Wallet System**: Create and manage multiple wallets (Primary, Savings, Investment)
- **Dynamic Multi-Currency**: 
  - Default currency set to **MYR (RM)**
  - Real-time switching between USD ($), MYR (RM), EUR (€), SGD (S$), GBP (£), IDR (Rp)
  - Dynamic currency symbol updates across all screens
  - High-quality asset-based country flags
- **Wallet Operations**:
  - Quick top-up with customizable amounts
  - Auto-reload functionality with threshold settings
  - Set default payment methods
  - Detailed transaction history with categorization
  - Hero animations for seamless navigation

### 🤖 AI-Powered Insights
- **3-Tab Intelligence Dashboard**:
  - **Overview**: Real-time income vs expense tracking, 6-month balance trends, budget monitoring
  - **Predictions**: 6-month financial projections, savings forecasts (3/6/12 months)
  - **Actionable Insights**: Smart cards with concrete savings opportunities and detailed reports

- **Smart Analytics**:
  - Balance growth tracking with percentage indicators
  - Top spending categories with visual progress bars
  - Goal achievement timelines
  - Behavioral pattern recognition
  - Transaction-level insights

### 🛍️ Mini Programs Ecosystem
Integrated services accessible directly from the wallet:

- **Shopping**:
  - Shopee, Lazada, Taobao integration
  - AI-powered best price finder across platforms
  - Smart product search

- **Food Delivery**:
  - GrabFood, FoodPanda, Shopeefood
  - AI cuisine recommendations
  - Popular restaurant listings

- **Transportation**:
  - Grab, Bolt, InDrive ride-hailing
  - AI cheapest ride selector
  - Route optimization

- **Travel & Accommodation**:
  - AirAsia, Firefly, MalaysiaAirlines flight booking
  - Booking.com, Agoda, Airbnb hotel reservations
  - AI best rate finder

### 💸 Transaction Management
- **Send Money**:
  - AI-powered recipient verification with trust scores
  - Real-time fraud detection alerts
  - QR code generation for quick transfers

- **Receive Money**:
  - Personal QR codes with dynamic amounts
  - NFC-ready payment acceptance
  - Instant notifications

- **Transaction History**:
  - Filterable by type (All, Sent, Received, Top-up)
  - Detailed transaction records
  - Export capabilities
  - Search and categorization

### 🔗 Linked Accounts
- **Banking Integration**: Link multiple bank accounts and credit cards
- **Quick Access**: View balances and recent transactions from linked accounts
- **Unified Management**: Centralized control of all financial accounts

### 👤 Profile & Settings
- **Personal Information**: Comprehensive profile management
- **Security Settings**:
  - Biometric authentication toggle
  - Two-factor authentication
  - PIN code management
  - Session timeout configuration

- **Preferences**:
  - Currency selection
  - Language options
  - Notification controls
  - Theme customization

- **Privacy Controls**:
  - Data export options
  - Privacy settings
  - AI feature toggles

---

## 🎨 Screenshots

<div align="center">

| Home Screen | Wallet Details | AI Insights |
|------------|----------------|-------------|
| Multi-wallet dashboard with quick actions | Detailed wallet view with management options | AI-powered financial analytics |

| Transactions | Mini Programs | Send Money |
|-------------|---------------|------------|
| Complete transaction history | Integrated shopping & services | Smart transfer with AI verification |

</div>

---

## 🚀 Installation

### Prerequisites

- Flutter SDK: `>=3.6.2 <4.0.0`
- Dart SDK: `>=3.6.2 <4.0.0`
- iOS 12.0+ or Android 5.0+ (API level 21+)

### Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/kimhongzhang323/KimPay.git
   cd PaymentWallet/nlp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For Android
   flutter run

   # For iOS
   flutter run -d ios

   # For web
   flutter run -d chrome
   ```

### Build for Production

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## 📦 Dependencies

### Core Framework
- **flutter**: Flutter SDK
- **cupertino_icons**: ^1.0.8 - iOS-style icons

### UI & Design
- **google_fonts**: ^6.3.0 - Custom typography
- **font_awesome_flutter**: ^10.9.1 - Icon library
- **animations**: ^2.0.11 - Advanced animations
- **shimmer**: ^3.0.0 - Loading effects

### Data Visualization
- **fl_chart**: ^0.69.2 - Beautiful charts and graphs

### Payments & Cards
- **flutter_credit_card**: ^4.1.0 - Credit card UI components

### QR & Scanning
- **qr_flutter**: ^4.1.0 - QR code generation
- **mobile_scanner**: ^5.2.3 - QR code scanning

### Graphics
- **flutter_svg**: ^2.2.0 - SVG support

### State Management
- **provider**: ^6.1.5 - State management solution

### Internationalization
- **intl**: ^0.19.0 - Date, number, and currency formatting

---

## 🏗️ Architecture

### Project Structure

```
lib/
├── main.dart                      # App entry point
├── design_system/
│   └── app_colors.dart           # Color palette & gradients
├── models/
│   └── wallet.dart               # Data models
├── screens/
│   ├── dashboard_screen.dart     # Main navigation hub
│   ├── home_content.dart         # Home screen with wallets
│   ├── ai_insights_screen.dart   # AI analytics dashboard
│   ├── transactions_screen.dart  # Transaction history
│   ├── wallet_detail_screen.dart # Individual wallet management
│   ├── send_money_screen.dart    # Transfer functionality
│   ├── receive_money_screen.dart # Receive payments
│   ├── mini_program_screen.dart  # Mini programs hub
│   ├── linked_accounts_screen.dart # Account management
│   └── profile_screen.dart       # User settings
├── widgets/
│   ├── wallet_card.dart          # Wallet display component
│   ├── transaction_list_item.dart # Transaction card
│   └── ai_chatbot_widget.dart    # AI assistant
├── data/
│   ├── mock_data.dart            # Sample data
│   └── linked_accounts_data.dart # Account data
└── utils/
    └── currency_converter.dart   # Currency utilities
```

### Design Patterns

- **State Management**: Provider pattern for reactive state updates
- **Navigation**: PageRouteBuilder for custom transitions with Hero animations
- **UI Components**: Modular widget architecture for reusability
- **Data Flow**: Unidirectional data flow with clear separation of concerns

### Key Technologies

- **Material 3**: Modern design language with dynamic theming
- **Custom Animations**: PageTransition, Hero animations, and shimmer effects
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Mock Data**: Simulated backend for demonstration purposes

---

## 🎯 Roadmap

### Upcoming Features

- [ ] **Backend Integration**: Real API connectivity with secure authentication
- [ ] **Blockchain Support**: Cryptocurrency wallet integration
- [ ] **Bill Payments**: Utilities, subscriptions, and recurring payments
- [ ] **Investment Portfolio**: Stock and fund tracking
- [ ] **Loan Management**: Personal loans and credit facilities
- [ ] **Insurance Integration**: Policy management and claims
- [ ] **Budget Goals**: Custom savings goals with progress tracking
- [ ] **Social Features**: Split bills and group payments
- [ ] **Offline Mode**: Local data persistence and sync
- [ ] **Biometric Security**: Fingerprint and Face ID authentication
- [ ] **Push Notifications**: Real-time transaction alerts
- [ ] **Export Reports**: PDF/CSV transaction reports
- [ ] **Multi-language Support**: Localization for global users

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Contribution Guidelines

- Follow Flutter best practices and style guidelines
- Write clear, commented code
- Update documentation for new features
- Add tests for new functionality
- Ensure all tests pass before submitting PR

---

## 🐛 Bug Reports & Feature Requests

Found a bug or have an idea for improvement? We'd love to hear from you!

- **Bug Reports**: [Open an issue](https://github.com/kimhongzhang323/KimPay/issues) with detailed steps to reproduce
- **Feature Requests**: Share your ideas in the [Discussions](https://github.com/kimhongzhang323/KimPay/discussions) section

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Kim Hong Zhang**

- GitHub: [@kimhongzhang323](https://github.com/kimhongzhang323)
- Repository: [KimPay](https://github.com/kimhongzhang323/KimPay)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Open-source community for valuable packages
- Material Design for design inspiration
- AI/ML community for financial analytics insights

---

## 📞 Support

Need help or have questions?

- 📧 Email: support@kimpay.app (placeholder)
- 💬 Discord: [Join our community](https://discord.gg/kimpay) (placeholder)
- 📖 Documentation: [docs.kimpay.app](https://docs.kimpay.app) (placeholder)

---

<div align="center">

### ⭐ Star this repository if you find it helpful!

**Built with ❤️ using Flutter**

[Back to Top](#-kimpay---smart-payment-wallet)

</div>

