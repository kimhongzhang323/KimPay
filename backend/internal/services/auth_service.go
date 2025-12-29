package services

import (
	"errors"
	"kimpay-backend/internal/database"
	"kimpay-backend/internal/models"
	"kimpay-backend/internal/utils"

	"gorm.io/gorm"
)

type AuthService struct{}

func NewAuthService() *AuthService {
	return &AuthService{}
}

func (s *AuthService) Register(req models.RegisterRequest) (models.User, error) {
	// Check if email exists
	var existingUser models.User
	if err := database.DB.Where("email = ?", req.Email).First(&existingUser).Error; err == nil {
		return models.User{}, errors.New("email already registered")
	}

	// Hash password
	hashedPassword, err := utils.HashPassword(req.Password)
	if err != nil {
		return models.User{}, err
	}

	// Create User with transaction to ensure wallet creation
	var newUser models.User
	err = database.DB.Transaction(func(tx *gorm.DB) error {
		user := models.User{
			Username:     req.Username,
			Email:        req.Email,
			PasswordHash: hashedPassword,
			FullName:     req.FullName,
		}

		if err := tx.Create(&user).Error; err != nil {
			return err
		}

		// Create default MYR wallet
		wallet := models.Wallet{
			UserID:   user.ID,
			Currency: "MYR",
			Balance:  0.0,
			Type:     "primary",
		}
		if err := tx.Create(&wallet).Error; err != nil {
			return err
		}

		// Create default USD wallet
		usdWallet := models.Wallet{
			UserID:   user.ID,
			Currency: "USD",
			Balance:  0.0,
			Type:     "secondary",
		}
		if err := tx.Create(&usdWallet).Error; err != nil {
			return err
		}

		newUser = user
		return nil
	})

	if err != nil {
		return models.User{}, err
	}

	return newUser, nil
}

func (s *AuthService) Login(req models.LoginRequest) (string, models.User, error) {
	var user models.User
	if err := database.DB.Where("email = ?", req.Email).First(&user).Error; err != nil {
		return "", models.User{}, errors.New("invalid email or password")
	}

	if !utils.CheckPasswordHash(req.Password, user.PasswordHash) {
		return "", models.User{}, errors.New("invalid email or password")
	}

	token, err := utils.GenerateToken(user.ID)
	if err != nil {
		return "", models.User{}, err
	}

	return token, user, nil
}
