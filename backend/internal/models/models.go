package models

import (
	"time"

	"gorm.io/gorm"
)

// --------------------------------------------------------
// 1. Identity & Access Management (IAM)
// --------------------------------------------------------

type User struct {
	gorm.Model
	Username       string         `gorm:"uniqueIndex;not null;size:50" json:"username"`
	Email          string         `gorm:"uniqueIndex;not null;size:100" json:"email"`
	PasswordHash   string         `gorm:"not null" json:"-"`
	PinHash        string         `json:"-"`
	Role           string         `gorm:"default:'USER'" json:"role"` // USER, ADMIN, COMPLIANCE
	IsActive       bool           `gorm:"default:true" json:"is_active"`
	IsVerified     bool           `gorm:"default:false" json:"is_verified"` // KYC Status
	
	// Relations
	Profile        UserProfile    `json:"profile"`
	Wallets        []Wallet       `json:"wallets"`
	LinkedAccounts []LinkedAccount `json:"linked_accounts"`
	Devices        []Device       `json:"devices"`
	Notifications  []Notification `json:"notifications"`
}

type UserProfile struct {
	gorm.Model
	UserID        uint      `gorm:"uniqueIndex" json:"user_id"`
	FullName      string    `gorm:"size:100" json:"full_name"`
	DateOfBirth   time.Time `json:"date_of_birth"`
	PhoneNumber   string    `gorm:"index;size:20" json:"phone_number"`
	AddressLine1  string    `json:"address_line_1"`
	AddressLine2  string    `json:"address_line_2"`
	City          string    `json:"city"`
	Country       string    `json:"country"`
	AvatarURL     string    `json:"avatar_url"`
	KYCLevel      int       `gorm:"default:1" json:"kyc_level"` // 1=Basic, 2=Full
}

type Device struct {
	gorm.Model
	UserID      uint      `gorm:"index" json:"user_id"`
	DeviceID    string    `gorm:"size:255" json:"device_id"`
	DeviceType  string    `json:"device_type"` // IOS, ANDROID, WEB
	LastLoginAt time.Time `json:"last_login_at"`
	IPAddress   string    `json:"ip_address"`
}

// --------------------------------------------------------
// 2. Financial Core
// --------------------------------------------------------

type Wallet struct {
	gorm.Model
	UserID    uint    `gorm:"index" json:"user_id"`
	Currency  string  `gorm:"size:3;index" json:"currency"` // USD, MYR, SGD
	Type      string  `gorm:"default:'MAIN'" json:"type"`   // MAIN, SAVINGS, INVESTMENT
	Balance   float64 `gorm:"type:decimal(20,8);default:0" json:"balance"`
	IsFrozen  bool    `gorm:"default:false" json:"is_frozen"`
	
	Transactions []Transaction `json:"-"`
}

type LinkedAccount struct {
	gorm.Model
	UserID        uint   `gorm:"index" json:"user_id"`
	Institution   string `json:"institution"`    // Bank Name
	AccountNumber string `json:"account_number"` // Masked
	Type          string `json:"type"`           // BANK, CARD
	IsActive      bool   `json:"is_active"`
}

type Beneficiary struct {
	gorm.Model
	UserID        uint   `gorm:"index" json:"user_id"`
	Name          string `json:"name"`
	AccountNumber string `json:"account_number"`
	BankName      string `json:"bank_name"`
	Currency      string `json:"currency"`
	Relationship  string `json:"relationship"`
}

// --------------------------------------------------------
// 3. Ledger System
// --------------------------------------------------------

type Transaction struct {
	gorm.Model
	WalletID        uint      `gorm:"index" json:"wallet_id"`
	RelatedWalletID *uint     `gorm:"index" json:"related_wallet_id"` // Counterparty Wallet
	RelatedUserID   *uint     `json:"related_user_id"`                // Counterparty User
	Type            string    `gorm:"index;size:20" json:"type"`      // CREDIT, DEBIT
	Category        string    `gorm:"index;size:20" json:"category"`  // TRANSFER, TOPUP, PAYMENT, EXCHANGE
	Amount          float64   `gorm:"type:decimal(20,8)" json:"amount"`
	Fee             float64   `gorm:"type:decimal(20,8);default:0" json:"fee"`
	Currency        string    `gorm:"size:3" json:"currency"`
	Status          string    `gorm:"index;default:'PENDING'" json:"status"` // PENDING, COMPLETED, FAILED, REVERSED
	Description     string    `json:"description"`
	Reference       string    `gorm:"uniqueIndex;size:50" json:"reference"`
	Metadata        string    `gorm:"type:jsonb" json:"metadata"` // JSON string for extra details
}

// --------------------------------------------------------
// 4. Investment & Market
// --------------------------------------------------------

type Asset struct {
	Symbol       string  `gorm:"primaryKey;size:10" json:"symbol"`
	Name         string  `json:"name"`
	Type         string  `json:"type"`          // CRYPTO, STOCK, FOREX
	CurrentPrice float64 `json:"current_price"` // Cached price
	LogoURL      string  `json:"logo_url"`
}

type Portfolio struct {
	gorm.Model
	UserID      uint    `gorm:"uniqueIndex:idx_user_asset" json:"user_id"`
	AssetSymbol string  `gorm:"uniqueIndex:idx_user_asset;size:10" json:"asset_symbol"`
	Quantity    float64 `gorm:"type:decimal(20,8)" json:"quantity"`
	AvgBuyPrice float64 `gorm:"type:decimal(20,8)" json:"avg_buy_price"`
}

type Watchlist struct {
	UserID      uint   `gorm:"primaryKey" json:"user_id"`
	AssetSymbol string `gorm:"primaryKey;size:10" json:"asset_symbol"`
}

// --------------------------------------------------------
// 5. System & Audit
// --------------------------------------------------------

type AuditLog struct {
	gorm.Model
	UserID    uint      `gorm:"index" json:"user_id"`
	Action    string    `json:"action"` // LOGIN, LOGOUT, CHANGE_PASS
	IPAddress string    `json:"ip_address"`
	UserAgent string    `json:"user_agent"`
	Resource  string    `json:"resource"`
	Details   string    `json:"details"`
}

type Notification struct {
	gorm.Model
	UserID  uint   `gorm:"index" json:"user_id"`
	Title   string `json:"title"`
	Body    string `json:"body"`
	Type    string `json:"type"`            // TRANSACTION, SECURITY, SYSTEM
	IsRead  bool   `gorm:"default:false" json:"is_read"`
}

// --------------------------------------------------------
// Request DTOs
// --------------------------------------------------------

type LoginRequest struct {
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type RegisterRequest struct {
	Username string `json:"username" binding:"required"`
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
	FullName string `json:"full_name"`
}
