package services

import (
	"errors"
	"fmt"
	"kimpay-backend/internal/database"
	"kimpay-backend/internal/models"
	"time"

	"gorm.io/gorm"
)

type TransactionService struct{}

func NewTransactionService() *TransactionService {
	return &TransactionService{}
}

func (s *TransactionService) GetTransactions(userID uint) ([]models.Transaction, error) {
	// Join with wallets to verify ownership
	var transactions []models.Transaction
	err := database.DB.Joins("JOIN wallets ON wallets.id = transactions.wallet_id").
		Where("wallets.user_id = ?", userID).
		Order("transactions.timestamp desc").
		Find(&transactions).Error
	return transactions, err
}

// TopUp adds money to a wallet (Simulated bank transfer)
func (s *TransactionService) TopUp(userID uint, walletID uint, amount float64) (models.Transaction, error) {
	if amount <= 0 {
		return models.Transaction{}, errors.New("invalid amount")
	}

	var transaction models.Transaction
	err := database.DB.Transaction(func(tx *gorm.DB) error {
		// 1. Verify wallet ownership
		var wallet models.Wallet
		if err := tx.Where("id = ? AND user_id = ?", walletID, userID).First(&wallet).Error; err != nil {
			return errors.New("wallet not found")
		}

		// 2. Update balance
		wallet.Balance += amount
		if err := tx.Save(&wallet).Error; err != nil {
			return err
		}

		// 3. Create Record
		transaction = models.Transaction{
			WalletID:    wallet.ID,
			Amount:      amount,
			Type:        "credit",
			Category:    "topup",
			Description: "Wallet Top-up",
			Reference:   fmt.Sprintf("TOP-%d-%d", walletID, time.Now().UnixNano()),
			Status:      "success",
			Timestamp:   time.Now(),
		}
		return tx.Create(&transaction).Error
	})

	return transaction, err
}

// Transfer moved funds between wallets (Peer-to-Peer)
// This is "Mocked" slightly as we assume we know target wallet ID, 
// in real app we'd look up by recipient email/phone
func (s *TransactionService) Transfer(fromUserID uint, fromWalletID uint, toWalletID uint, amount float64, description string) (models.Transaction, error) {
	if amount <= 0 {
		return models.Transaction{}, errors.New("invalid amount")
	}

	var senderTx models.Transaction
	
	err := database.DB.Transaction(func(tx *gorm.DB) error {
		// 1. Check Sender Wallet
		var senderWallet models.Wallet
		if err := tx.Where("id = ? AND user_id = ?", fromWalletID, fromUserID).First(&senderWallet).Error; err != nil {
			return errors.New("sender wallet not found")
		}

		if senderWallet.Balance < amount {
			return errors.New("insufficient funds")
		}

		// 2. Check Receiver Wallet
		var receiverWallet models.Wallet
		if err := tx.Where("id = ?", toWalletID).First(&receiverWallet).Error; err != nil {
			return errors.New("receiver wallet not found")
		}

		if senderWallet.Currency != receiverWallet.Currency {
			return errors.New("currency mismatch (cross-currency transfer not implemented in MVP)")
		}

		// 3. Deduct from Sender
		senderWallet.Balance -= amount
		if err := tx.Save(&senderWallet).Error; err != nil {
			return err
		}

		// 4. Add to Receiver
		receiverWallet.Balance += amount
		if err := tx.Save(&receiverWallet).Error; err != nil {
			return err
		}

		// 5. Create Sender Transaction Record
		ref := fmt.Sprintf("TRX-%d-%d", fromWalletID, time.Now().UnixNano())
		senderTx = models.Transaction{
			WalletID:      senderWallet.ID,
			Amount:        amount,
			Type:          "debit",
			Category:      "transfer",
			Description:   "Transfer to Wallet " + fmt.Sprint(toWalletID),
			Reference:     ref,
			RelatedUserID: &receiverWallet.UserID,
			Status:        "success",
			Timestamp:     time.Now(),
		}
		if err := tx.Create(&senderTx).Error; err != nil {
			return err
		}

		// 6. Create Receiver Transaction Record
		receiverTx := models.Transaction{
			WalletID:      receiverWallet.ID,
			Amount:        amount,
			Type:          "credit",
			Category:      "transfer",
			Description:   "Received from User " + fmt.Sprint(fromUserID), // ideally convert to name
			Reference:     ref, // Same reference to link them
			RelatedUserID: &fromUserID,
			Status:        "success",
			Timestamp:     time.Now(),
		}
		if err := tx.Create(&receiverTx).Error; err != nil {
			return err
		}
		
		return nil
	})

	return senderTx, err
}
