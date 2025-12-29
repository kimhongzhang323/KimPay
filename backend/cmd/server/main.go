package main

import (
	"log"
	"kimpay-backend/internal/cache"
	"kimpay-backend/internal/database"
	"kimpay-backend/internal/gql"
	"kimpay-backend/internal/handlers"
	"kimpay-backend/internal/middleware"
	"kimpay-backend/internal/queue"

	"github.com/gin-gonic/gin"
	"github.com/graphql-go/handler"
)

func main() {
	log.Println("Starting KimPay Professional Backend...")

	// 1. Connect Dependencies
	database.Connect()        // PostgreSQL
	cache.Connect()           // Redis

	// 2. Start Message Consumers (Redis Queue)
	consumer := queue.NewRedisConsumer()
	// Spawn 5 concurrent consumers
	for i := 1; i <= 5; i++ {
		go consumer.StartConsumer(i)
	}

	// 3. Setup Gin
	r := gin.Default()

	// 4. GraphQL Handler
	h := handler.New(&handler.Config{
		Schema:   &gql.Schema,
		Pretty:   true,
		GraphiQL: true,
	})

	// 5. Handlers
	authHandler := handlers.NewAuthHandler()
	walletHandler := handlers.NewWalletHandler() // Now uses Redis internally
	marketHandler := handlers.NewMarketHandler()

	// 6. Routes
	r.GET("/graphql", gin.WrapH(h)) // GraphQL Endpoint
	r.POST("/graphql", gin.WrapH(h))

	api := r.Group("/api")
	{
		api.POST("/register", authHandler.Register)
		api.POST("/login", authHandler.Login)
		
		api.GET("/market/crypto", marketHandler.GetCryptoPrices)
		api.GET("/market/rates", marketHandler.GetExchangeRates)

		protected := api.Group("/")
		protected.Use(middleware.AuthMiddleware())
		{
			protected.GET("/wallets", walletHandler.GetWallets)
			protected.POST("/wallets/topup", walletHandler.TopUp)
			protected.GET("/transactions", walletHandler.GetTransactions)
			protected.POST("/transactions/transfer", walletHandler.Transfer) // Pushes to Redis
		}
	}

	// 7. Run
	r.Run(":8080")
}
