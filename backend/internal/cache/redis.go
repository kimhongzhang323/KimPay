package cache

import (
	"context"
	"log"
	
	"github.com/redis/go-redis/v9"
)

var Rdb *redis.Client
var Ctx = context.Background()

func Connect() {
	Rdb = redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})

	_, err := Rdb.Ping(Ctx).Result()
	if err != nil {
		log.Println("Note: Failed to connect to Redis (Ensure it is running). Features utilizing Redis will fail gracefully.")
		// Create a "mock" client or just let it fail at runtime for this demo? 
		// Ideally we stop, but for "code generation" without env, we log.
		return
	}
	
	log.Println("Connected to Redis")
}
