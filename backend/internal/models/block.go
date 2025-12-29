package models

import (
	"time"
)

// Block represents a single block in the chain
type Block struct {
	Index        uint64    `gorm:"primaryKey" json:"index"` 
	Timestamp    time.Time `json:"timestamp"`
	
	// Data
	TransactionRef string `json:"transaction_ref"` // Link to the SQL Transaction
	Data           string `gorm:"type:text" json:"data"` // JSON Payload of the tx
	
	// Security
	PrevHash     string    `json:"prev_hash"`
	Hash         string    `gorm:"uniqueIndex" json:"hash"`
	Nonce        int       `json:"nonce"`
	Difficulty   int       `json:"difficulty"`
}
