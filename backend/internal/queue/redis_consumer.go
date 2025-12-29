package queue

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"kimpay-backend/internal/cache"
	"kimpay-backend/internal/services"
)

const QueueKey = "tx_queue"

type RedisConsumer struct {
	txService    *services.TransactionService
	chainService *services.BlockchainService
}

func NewRedisConsumer() *RedisConsumer {
	return &RedisConsumer{
		txService:    services.NewTransactionService(),
		chainService: services.NewBlockchainService(),
	}
}

// StartConsumer simulates a worker reading from Redis List (Queue)
func (c *RedisConsumer) StartConsumer(workerID int) {
	log.Printf("Redis Consumer %d started", workerID)
	for {
		// BLPOP blocks until an item is available in the list
		result, err := cache.Rdb.BLPop(context.Background(), 0, QueueKey).Result()
		if err != nil {
			// If Redis is down or connection closed
			continue
		}

		// result[1] contains the payload
		payload := result[1]
		var jobData TransactionPayload
		if err := json.Unmarshal([]byte(payload), &jobData); err != nil {
			log.Printf("Failed to unmarshal job: %v", err)
			continue
		}

		log.Printf("Consumer %d Processing: %s (Amount: %.2f)", workerID, jobData.Description, jobData.Amount)
		
		tx, err := c.txService.Transfer(jobData.FromUserID, jobData.FromWalletID, jobData.ToWalletID, jobData.Amount, jobData.Description)
		if err != nil {
			log.Printf("Transaction Failed: %v", err)
		} else {
			log.Printf("Transaction Success: %s", jobData.Reference)
			
			// BLOCKCHAIN INTEGRATION: Mine the block
			// We can fire this asynchronously so consumer speed isn't bogged down by mining difficulty
			go func() {
				_, err := c.chainService.AddBlock(*tx)
				if err != nil {
					log.Printf("Mining Failed: %v", err)
				}
			}()
		}
	}
}

// Struct to serialize job data
type TransactionPayload struct {
	FromUserID   uint    `json:"from_user_id"`
	FromWalletID uint    `json:"from_wallet_id"`
	ToWalletID   uint    `json:"to_wallet_id"`
	Amount       float64 `json:"amount"`
	Description  string  `json:"description"`
	Reference    string  `json:"reference"`
}

// Publisher function
func EnqueueJob(payload TransactionPayload) error {
	data, _ := json.Marshal(payload)
	// LPUSH adds to the head of the list
	return cache.Rdb.LPush(context.Background(), QueueKey, data).Err()
}
