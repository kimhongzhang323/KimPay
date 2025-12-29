<div align="center">

# 💳 KimPay - Smart Payment Wallet

### Next-Generation Digital Wallet with AI-Powered Financial Intelligence

[![Flutter](https://img.shields.io/badge/Flutter-3.6.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web-blue?style=for-the-badge)](https://flutter.dev)

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Architecture](#-architecture) • [Contributing](#-contributing)

---

</div>

## 📋 Overview

**KimPay** is a comprehensive Flutter-based mobile payment wallet that revolutionizes personal finance management through AI-powered insights, cryptocurrency exchange, stock trading, and seamless multi-currency support. Designed with a modern, intuitive interface featuring a floating navigation bar, KimPay empowers users to manage their finances, trade digital assets, track spending patterns, and make informed financial decisions with intelligent predictions and recommendations.

### Why KimPay?

- 🤖 **AI-Powered Intelligence**: Advanced machine learning algorithms analyze spending patterns and provide personalized financial insights
- 💱 **Multi-Currency Support**: Seamlessly manage multiple wallets across different currencies (USD, MYR, SGD, EUR, GBP, IDR)
- 📈 **Crypto & Stock Trading**: Built-in exchange for cryptocurrencies and stock portfolio management with AI analysis
- 🖼️ **NFT Marketplace**: Browse, buy, and manage NFTs with AI-powered rarity and authenticity verification
- 📊 **Comprehensive Analytics**: Detailed visualizations and reports of income, expenses, and savings projections
- 🛍️ **Integrated Mini Programs**: Shop, order food, book rides, hotels, and flights directly within the app
- 🔒 **Secure Transactions**: SHA-256 encrypted PIN authentication with secure local storage
- 📱 **QR Code Scanning**: Real-time QR code scanning for instant payments
- 🎨 **Modern UI/UX**: Beautiful, Material 3 design with smooth animations, floating nav bar, and intuitive navigation

---

## ✨ Features

### 💰 Core Wallet Management
- **Multi-Wallet System**: Create and manage multiple wallets (Primary, Savings, Investment)
- **Dynamic Multi-Currency**: 
  - Default currency set to **MYR (RM)**
  - Real-time switching between USD ($), MYR (RM), EUR (€), SGD (S$), GBP (£), IDR (Rp)
  - Live currency conversion with up-to-date exchange rates
  - Dynamic currency symbol updates across all screens
  - High-quality asset-based country flags for 12+ countries
- **Wallet Operations**:
  - Quick top-up with customizable amounts
  - Auto-reload functionality with threshold settings
  - Set default payment methods
  - Detailed transaction history with categorization
  - Hero animations for seamless navigation

### 🔐 Security & Authentication
- **PIN Security System**:
  - 6-digit PIN setup during onboarding
  - SHA-256 encrypted PIN storage
  - PIN verification for app access
  - PIN change functionality with old PIN verification
  - Secure local storage using SharedPreferences
- **Splash & Onboarding**:
  - Animated splash screen
  - Interactive onboarding flow
  - First-time user setup wizard

### 💹 Exchange & Trading
- **Cryptocurrency Exchange**:
  - Real-time crypto-to-fiat conversion
  - Support for BTC, ETH, SOL, LTC, DOGE
  - Interactive price charts with multiple timeframes (1H, 1D, 1W, 1M, 1Y)
  - AI-powered trading recommendations and signals
- **Stock Portfolio**:
  - View and manage stock holdings (AAPL, TSLA, MSFT, etc.)
  - AI sentiment analysis and risk assessment
  - Buy/Sell recommendations with target prices
  - Detailed stock charts and technical analysis
- **NFT Gallery**:
  - Browse NFT collections (Bored Ape, CryptoPunk, Azuki, etc.)
  - AI rarity scoring and price predictions
  - Blockchain authenticity verification
  - Provenance tracking and ownership history

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

- **AI Trading Assistant**:
  - Crypto buy/sell signals with probability scores
  - Stock recommendations based on fundamentals and technicals
  - NFT rarity and authenticity analysis
  - Risk level assessment for each asset

### 📱 QR Code Integration
- **QR Scanner**:
  - Real-time camera-based QR code scanning
  - Support for KimPay payment protocol (`kimpay://pay`)
  - Flash toggle and camera flip functionality
  - Free amount or fixed amount payment modes
- **QR Generation**:
  - Generate personal payment QR codes
  - Dynamic amount encoding
  - Share QR codes for receiving payments

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
  - Multiple recipient support

- **Receive Money**:
  - Personal QR codes with dynamic amounts
  - NFC-ready payment acceptance
  - Instant notifications

- **Transaction History**:
  - Filterable by type (All, Sent, Received, Top-up)
  - Detailed transaction records with metadata
  - Search and categorization
  - Transaction detail view with full breakdown

### 🔗 Linked Accounts
- **Banking Integration**: Link multiple bank accounts and credit cards
- **Quick Access**: View balances and recent transactions from linked accounts
- **Unified Management**: Centralized control of all financial accounts
- **Account Authorization**: Secure OAuth-style account linking flow

### 👤 Profile & Settings
- **Personal Information**: Comprehensive profile management with avatar
- **Statistics Dashboard**:
  - Total transactions count
  - Active linked accounts
  - Rewards points balance

- **Security Settings**:
  - PIN code setup and management
  - Biometric authentication toggle
  - Two-factor authentication
  - Session timeout configuration

- **Preferences**:
  - Currency selection with live conversion
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

| Home Screen | Exchange | AI Insights |
|------------|----------|-------------|
| Multi-wallet dashboard with floating nav | Crypto exchange with live charts | AI-powered financial analytics |

| Crypto Detail | Stock Detail | NFT Gallery |
|---------------|--------------|-------------|
| AI trading signals & analysis | Sentiment analysis & recommendations | Rarity scoring & verification |

| Transactions | Mini Programs | QR Scanner |
|-------------|---------------|------------|
| Complete transaction history | Integrated shopping & services | Real-time payment scanning |

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
   cd KimPay/nlp
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

# Android App Bundle
flutter build appbundle --release

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
- **fl_chart**: ^0.69.2 - Beautiful charts and graphs for crypto, stocks, and analytics

### Payments & Cards
- **flutter_credit_card**: ^4.1.0 - Credit card UI components

### QR Code
- **qr_flutter**: ^4.1.0 - QR code generation
- **mobile_scanner**: ^5.2.3 - Real-time QR code scanning with camera

### Graphics
- **flutter_svg**: ^2.2.0 - SVG support

### State Management
- **provider**: ^6.1.5 - State management solution

### Internationalization
- **intl**: ^0.19.0 - Date, number, and currency formatting

### Storage & Security
- **shared_preferences**: ^2.3.4 - Secure local storage for PIN and settings
- **shared_preferences_web**: ^2.4.2 - Web platform support
- **crypto**: ^3.0.6 - SHA-256 encryption for PIN security

---

## 🏗️ Architecture

### Project Structure

```
lib/
├── main.dart                           # App entry point with Material 3 theme
├── design_system/
│   └── app_colors.dart                 # Color palette & gradients
├── models/
│   ├── wallet.dart                     # Wallet data model
│   ├── transaction.dart                # Transaction data model
│   └── linked_account_models.dart      # Linked accounts model
├── screens/
│   ├── splash_screen.dart              # Animated splash screen
│   ├── onboarding_screen.dart          # First-time user onboarding
│   ├── pin_setup_screen.dart           # PIN creation flow
│   ├── pin_verify_screen.dart          # PIN verification
│   ├── dashboard_screen.dart           # Main navigation with floating nav bar
│   ├── home_content.dart               # Home screen with wallets & actions
│   ├── exchange_screen.dart            # Crypto exchange with charts
│   ├── crypto_detail_screen.dart       # Individual crypto analysis
│   ├── stock_detail_screen.dart        # Stock portfolio & AI insights
│   ├── nft_detail_screen.dart          # NFT gallery with rarity scores
│   ├── ai_insights_screen.dart         # AI analytics dashboard
│   ├── transactions_screen.dart        # Transaction history
│   ├── transaction_detail_screen.dart  # Individual transaction view
│   ├── wallet_detail_screen.dart       # Wallet management
│   ├── send_money_screen.dart          # Transfer functionality
│   ├── receive_money_screen.dart       # Receive payments
│   ├── topup_screen.dart               # Wallet top-up
│   ├── scan_screen.dart                # QR code scanner
│   ├── mini_program_screen.dart        # Mini programs hub
│   ├── more_programs_screen.dart       # Extended mini programs
│   ├── linked_accounts_screen.dart     # Account management
│   ├── account_detail_screen.dart      # Linked account details
│   ├── account_authorization_screen.dart # OAuth-style linking
│   ├── add_account_method_screen.dart  # Add new accounts
│   ├── profile_screen.dart             # User profile
│   └── settings_detail_screen.dart     # Detailed settings
├── services/
│   └── pin_service.dart                # PIN encryption & validation
├── widgets/
│   ├── wallet_card.dart                # Wallet display component
│   ├── transaction_list_item.dart      # Transaction card
│   ├── ai_chatbot_widget.dart          # AI assistant widget
│   └── pin_input_widget.dart           # PIN input component
├── data/
│   ├── mock_data.dart                  # Sample data for demo
│   └── linked_accounts_data.dart       # Account data
└── utils/
    └── currency_converter.dart         # Currency utilities
```

### Design Patterns

- **State Management**: Provider pattern for reactive state updates
- **Navigation**: PageRouteBuilder for custom transitions with Hero animations
- **UI Components**: Modular widget architecture for reusability
- **Data Flow**: Unidirectional data flow with clear separation of concerns
- **Security**: SHA-256 hashing for secure PIN storage

### Key Technologies

- **Material 3**: Modern design language with dynamic theming
- **Custom Animations**: PageTransition, Hero animations, and shimmer effects
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Floating Navigation**: Modern dark-themed floating bottom nav bar
- **Real-time Charts**: FL Chart for interactive financial visualizations
- **Camera Integration**: Mobile Scanner for QR code functionality
- **Mock Data**: Simulated backend for demonstration purposes

---

## 🎯 Roadmap

### Current Features ✅
- [x] Multi-wallet management with currency switching
- [x] Cryptocurrency exchange with AI insights
- [x] Stock portfolio tracking with recommendations
- [x] NFT gallery with rarity analysis
- [x] QR code scanning and generation
- [x] PIN-based security with SHA-256 encryption
- [x] Mini programs ecosystem
- [x] AI-powered financial insights
- [x] Transaction history and management
- [x] Linked accounts integration

### Upcoming Features

- [ ] **Backend Integration**: Real API connectivity with secure authentication
- [ ] **Live Market Data**: Real-time crypto and stock prices
- [ ] **Blockchain Support**: Actual cryptocurrency wallet integration
- [ ] **Bill Payments**: Utilities, subscriptions, and recurring payments
- [ ] **Investment Portfolio**: Real stock and fund trading
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
- Use meaningful commit messages

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

- Flutter team for the amazing cross-platform framework
- Open-source community for valuable packages
- Material Design 3 for modern design inspiration
- FL Chart for beautiful data visualization
- Mobile Scanner for seamless QR functionality

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

*Last Updated: December 2024*

[Back to Top](#-kimpay---smart-payment-wallet)

</div>

