package handlers

import (
	"kimpay-backend/internal/services"
	"net/http"

	"github.com/gin-gonic/gin"
)

type BlockchainHandler struct {
	service *services.BlockchainService
}

func NewBlockchainHandler() *BlockchainHandler {
	return &BlockchainHandler{
		service: services.NewBlockchainService(),
	}
}

func (h *BlockchainHandler) GetChain(c *gin.Context) {
	chain, err := h.service.GetChain()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch ledger"})
		return
	}
	
	valid := h.service.IsChainValid()
	
	c.JSON(http.StatusOK, gin.H{
		"ledger_height": len(chain),
		"is_valid":      valid,
		"blocks":        chain,
	})
}
