package queue

import (
	"kimpay-backend/internal/services"
	"log"
)

// TransactionJob wraps the transfer logic into a Job
type TransactionJob struct {
	Service      *services.TransactionService
	FromUserID   uint
	FromWalletID uint
	ToWalletID   uint
	Amount       float64
	Description  string
}

// Process implements the Job interface
func (j *TransactionJob) Process() error {
	log.Printf("Processing Transfer: Wallet %d -> %d ($%.2f)\n", j.FromWalletID, j.ToWalletID, j.Amount)
	
	// Execute the actual business logic
	_, err := j.Service.Transfer(j.FromUserID, j.FromWalletID, j.ToWalletID, j.Amount, j.Description)
	
	if err != nil {
		log.Printf("Transaction Failed: %v\n", err)
		return err
	}

	log.Println("Transaction Completed Successfully")
	return nil
}
