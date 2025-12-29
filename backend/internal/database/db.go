package database

import (
	"log"
	"kimpay-backend/internal/models"
	
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func Connect() {
	// Professional DB Setup: PostgreSQL
	dsn := "host=localhost user=kimpay password=securepassword dbname=kimpay port=5432 sslmode=disable TimeZone=Asia/Kuala_Lumpur"
	
	var err error
	DB, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Println("Note: Failed to connect to PostgreSQL (Ensure it is running).")
		// log.Fatal("Database connection failed") 
		return
	}

	log.Println("Connected to PostgreSQL Database")

	// Auto-migrate schema (Enhanced)
	log.Println("Running migrations for Professional Schema...")
	err = DB.AutoMigrate(
		&models.User{},
		&models.UserProfile{}, // Added
		&models.Device{},      // Added
		&models.Wallet{},
		&models.LinkedAccount{},
		&models.Beneficiary{}, // Added
		&models.Transaction{},
		&models.Asset{},       // Added
		&models.Portfolio{},   // Added
		&models.Watchlist{},   // Added
		&models.AuditLog{},    // Added
		&models.Notification{},// Added
		&models.Block{},       // Blockchain Ledger
	)
	if err != nil {
		log.Fatal("Migration failed:", err)
	}
	log.Println("Migrations completed successfully")
}
