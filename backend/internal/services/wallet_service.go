package services

import (
	"errors"
	"kimpay-backend/internal/database"
	"kimpay-backend/internal/models"
)

type WalletService struct{}

func NewWalletService() *WalletService {
	return &WalletService{}
}

func (s *WalletService) GetUserWallets(userID uint) ([]models.Wallet, error) {
	var wallets []models.Wallet
	if err := database.DB.Where("user_id = ?", userID).Find(&wallets).Error; err != nil {
		return nil, err
	}
	return wallets, nil
}

func (s *WalletService) GetWallet(walletID uint, userID uint) (models.Wallet, error) {
	var wallet models.Wallet
	if err := database.DB.Where("id = ? AND user_id = ?", walletID, userID).First(&wallet).Error; err != nil {
		return models.Wallet{}, errors.New("wallet not found or access denied")
	}
	return wallet, nil
}
