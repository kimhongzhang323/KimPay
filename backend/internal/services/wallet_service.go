package services

import (
	"context"
	"errors"
	"fmt"
	"log"
	
	"kimpay-backend/internal/database"
	"kimpay-backend/internal/models"
	"kimpay-backend/internal/utils"
	
	"gorm.io/gorm"
)

type WalletService struct {}

func NewWalletService() *WalletService {
	return &WalletService{}
}

// GetUserWallets now accepts Context to demonstrate "ThreadLocal" tracing
func (s *WalletService) GetUserWallets(userID uint) ([]models.Wallet, error) {
	var wallets []models.Wallet
	err := database.DB.Where("user_id = ?", userID).Find(&wallets).Error
	return wallets, err
}

// GetWalletWithContext demonstrates accessing the TraceID from the "Thread" (Goroutine)
func (s *WalletService) GetWalletWithContext(ctx context.Context, walletID uint) (*models.Wallet, error) {
	// 1. "ThreadLocal" Access: Get TraceID for logging
	traceID := utils.GetTraceID(ctx)
	log.Printf("[%s] Fetching Wallet %d", traceID, walletID)

	// 2. "ThreadLocal" Access: Ensure the UserID in context matches the wallet owner (Security)
	authUserID := utils.GetUserID(ctx)
	
	var wallet models.Wallet
	err := database.DB.Where("id = ?", walletID).First(&wallet).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("wallet not found")
		}
		return nil, err
	}

	if wallet.UserID != authUserID {
		log.Printf("[%s] Security Alert: User %d tried to access Wallet %d owned by %d", traceID, authUserID, walletID, wallet.UserID)
		return nil, errors.New("unauthorized access")
	}

	return &wallet, nil
}
