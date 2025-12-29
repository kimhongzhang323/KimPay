package middleware

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type contextKey string

const (
	UserIDKey = contextKey("UserID")
	TraceIDKey = contextKey("TraceID")
)

// RequestContextMiddleware injects "ThreadLocal" style data into the context
func RequestContextMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		// 1. Generate Correlation ID (Trace ID)
		traceID := uuid.New().String()
		c.Header("X-Trace-ID", traceID)
		
		// 2. Create a new Go context populated with our values
		// We inherit from the request context so timeouts work
		ctx := context.WithValue(c.Request.Context(), TraceIDKey, traceID)
		
		// If UserID is extracted by Auth middleware later, we can't inject it here yet
		// But in Go/Gin, middlewares run in chain.
		// We will set the Gin context first, then Auth middleware sets UserID in Gin keys.
		
		c.Request = c.Request.WithContext(ctx)
		c.Next()
	}
}

// PopulateContextFromAuth wraps Authenticated calls to ensure UserID is in standard Go context Not just Gin keys
func PopulateUserContext() gin.HandlerFunc {
	return func(c *gin.Context) {
		userID, exists := c.Get("userID")
		if exists {
			// Upgrade the Request Context to include UserID
			ctx := context.WithValue(c.Request.Context(), UserIDKey, userID)
			c.Request = c.Request.WithContext(ctx)
		}
		c.Next()
	}
}
