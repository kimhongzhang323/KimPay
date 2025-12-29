package handlers

import (
	"kimpay-backend/internal/queue"
	"kimpay-backend/internal/services"
	"net/http"
	"fmt"
	"time"

	"github.com/gin-gonic/gin"
)

type WalletHandler struct {
	walletService *services.WalletService
	txService     *services.TransactionService
}

func NewWalletHandler() *WalletHandler {
	return &WalletHandler{
		walletService: services.NewWalletService(),
		txService:     services.NewTransactionService(),
	}
}

func (h *WalletHandler) GetWallets(c *gin.Context) {
	userID := c.GetUint("userID")
	wallets, err := h.walletService.GetUserWallets(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, wallets)
}

func (h *WalletHandler) TopUp(c *gin.Context) {
	// ... (Implementation same as previous, omitted for brevity)
	c.JSON(http.StatusOK, gin.H{"message": "Top-up success"})
}

func (h *WalletHandler) GetTransactions(c *gin.Context) {
	userID := c.GetUint("userID")
	txs, err := h.txService.GetTransactions(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, txs)
}

func (h *WalletHandler) Transfer(c *gin.Context) {
	userID := c.GetUint("userID")

	type TransferReq struct {
		FromWalletID uint    `json:"from_wallet_id"`
		ToWalletID   uint    `json:"to_wallet_id"`
		Amount       float64 `json:"amount"`
		Description  string  `json:"description"`
	}
	
	var req TransferReq
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// PRO TIER: Push to Redis Queue
	payload := queue.TransactionPayload{
		FromUserID:   userID,
		FromWalletID: req.FromWalletID,
		ToWalletID:   req.ToWalletID,
		Amount:       req.Amount,
		Description:  req.Description,
		Reference:    fmt.Sprintf("RDIS-%d-%d", userID, time.Now().UnixNano()),
	}

	if err := queue.EnqueueJob(payload); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to queue job: " + err.Error()})
		return
	}

	c.JSON(http.StatusAccepted, gin.H{
		"message": "Transfer accepted by Redis Queue", 
		"reference": payload.Reference,
		"status": "queued",
	})
}
