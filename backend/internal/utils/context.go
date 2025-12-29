package utils

import (
	"context"
	"kimpay-backend/internal/middleware"
)

// GetUserID retrieves the UserID from current execution context ("ThreadLocal")
func GetUserID(ctx context.Context) uint {
	val := ctx.Value(middleware.UserIDKey)
	if val == nil {
		return 0
	}
	// Handle float64 (JWT defaults) vs uint mismatch safely
	switch v := val.(type) {
	case uint:
		return v
	case float64:
		return uint(v)
	case int:
		return uint(v)
	default:
		return 0
	}
}

// GetTraceID retrieves the TraceID for logging
func GetTraceID(ctx context.Context) string {
	val, ok := ctx.Value(middleware.TraceIDKey).(string)
	if !ok {
		return "unknown"
	}
	return val
}
