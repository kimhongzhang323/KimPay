package graphql

import (
	"kimpay-backend/internal/services"
	"github.com/graphql-go/graphql"
)

// Define User Type
var userType = graphql.NewObject(graphql.ObjectConfig{
	Name: "User",
	Fields: graphql.Fields{
		"id":       &graphql.Field{Type: graphql.Int},
		"username": &graphql.Field{Type: graphql.String},
		"email":    &graphql.Field{Type: graphql.String},
		"wallets":  &graphql.Field{
			Type: graphql.NewList(walletType),
			Resolve: func(p graphql.ResolveParams) (interface{}, error) {
				// Resolve nested wallets
				user, _ := p.Source.(map[string]interface{})
				userID := uint(user["id"].(int))
				return services.NewWalletService().GetUserWallets(userID)
			},
		},
	},
})

// Define Wallet Type
var walletType = graphql.NewObject(graphql.ObjectConfig{
	Name: "Wallet",
	Fields: graphql.Fields{
		"id":       &graphql.Field{Type: graphql.Int},
		"currency": &graphql.Field{Type: graphql.String},
		"balance":  &graphql.Field{Type: graphql.Float},
	},
})

// Root Query
var rootQuery = graphql.NewObject(graphql.ObjectConfig{
	Name: "RootQuery",
	Fields: graphql.Fields{
		"user": &graphql.Field{
			Type: userType,
			Args: graphql.FieldConfigArgument{
				"id": &graphql.ArgumentConfig{Type: graphql.Int},
			},
			Resolve: func(p graphql.ResolveParams) (interface{}, error) {
				id, ok := p.Args["id"].(int)
				if ok {
					// Mock fetching user for demo (real would use UserService)
					return map[string]interface{}{
						"id":       id,
						"username": "demo_user", 
						"email":    "demo@test.com",
					}, nil
				}
				return nil, nil
			},
		},
	},
})

var Schema, _ = graphql.NewSchema(graphql.SchemaConfig{
	Query: rootQuery,
})
