package services

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"log"
	"strings"
	"time"
	
	"kimpay-backend/internal/database"
	"kimpay-backend/internal/models"
)

type BlockchainService struct {}

func NewBlockchainService() *BlockchainService {
	return &BlockchainService{}
}

// AddBlock creates a new block based on a transaction, mines it, and saves to DB
func (s *BlockchainService) AddBlock(tx models.Transaction) (*models.Block, error) {
	var prevBlock models.Block
	
	// Get the last block to link headers
	result := database.DB.Order("index desc").First(&prevBlock)
	
	newIndex := uint64(1)
	prevHash := "0000000000000000000000000000000000000000000000000000000000000000" // Genesis PrevHash
	
	if result.Error == nil {
		newIndex = prevBlock.Index + 1
		prevHash = prevBlock.Hash
	}

	// Create Block Data
	data := fmt.Sprintf("TX: %s | FROM: %d | TO: %v | AMT: %.2f | CUR: %s", 
		tx.Reference, tx.WalletID, tx.RelatedWalletID, tx.Amount, tx.Currency)

	newBlock := &models.Block{
		Index:          newIndex,
		Timestamp:      time.Now(),
		TransactionRef: tx.Reference,
		Data:           data,
		PrevHash:       prevHash,
		Difficulty:     2, // Low difficulty for demo speed
		Nonce:          0,
	}

	// Mine (Proof of Work)
	s.MineBlock(newBlock)

	// Save to DB
	if err := database.DB.Create(newBlock).Error; err != nil {
		return nil, err
	}

	return newBlock, nil
}

// MineBlock performs a simple Proof of Work
func (s *BlockchainService) MineBlock(b *models.Block) {
	target := strings.Repeat("0", b.Difficulty)
	
	for {
		hash := s.CalculateHash(b)
		if strings.HasPrefix(hash, target) {
			b.Hash = hash
			break
		}
		b.Nonce++
	}
	log.Printf("Block #%d Mined! Hash: %s (Nonce: %d)\n", b.Index, b.Hash, b.Nonce)
}

// CalculateHash generates SHA-256 hash of the block content
func (s *BlockchainService) CalculateHash(b *models.Block) string {
	record := fmt.Sprintf("%d%s%s%s%d", b.Index, b.Timestamp.String(), b.Data, b.PrevHash, b.Nonce)
	h := sha256.New()
	h.Write([]byte(record))
	hashed := h.Sum(nil)
	return hex.EncodeToString(hashed)
}

// GetChain retrieves the full ledger
func (s *BlockchainService) GetChain() ([]models.Block, error) {
	var chain []models.Block
	err := database.DB.Order("index asc").Find(&chain).Error
	return chain, err
}

// IsChainValid checks integrity
func (s *BlockchainService) IsChainValid() bool {
	var chain []models.Block
	database.DB.Order("index asc").Find(&chain)

	for i := 1; i < len(chain); i++ {
		current := chain[i]
		prev := chain[i-1]

		// Check 1: Hash integrity
		if current.Hash != s.CalculateHash(&current) {
			return false
		}
		// Check 2: Link integrity
		if current.PrevHash != prev.Hash {
			return false
		}
	}
	return true
}
