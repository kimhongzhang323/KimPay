# KimPay Professional Backend

Enterprise-grade Go (Golang) backend for KimPay financial services.

## Architecture

This backend serves as a microservices-ready monolith (Modular Monolith) implementing:
-   **Clean Architecture:** (Handlers -> Services -> Repositories)
-   **Database:** **PostgreSQL** for ACID-compliant financial records.
-   **Caching & Messaging:** **Redis** used for caching market data and implementing the Distributed Job Queue.
-   **API Protocols:**
    -   **REST:** Standard JSON APIs for mobile clients.
    -   **GraphQL:** Flexible data fetching at `/graphql`.
    -   **gRPC:** Proto definitions available in `rpc/` for internal service calls.

## Services
-   **Auth Service:** JWT generation, bcrypt hashing.
-   **Wallet Service:** Multi-currency logic, PostgreSQL transactions.
-   **Queue Service:** Redis List-based consumer (Worker Pool) for high-frequency transactions.
-   **Market Service:** Connects to CoinGecko & Frankfurter APIs.

## Setup

### Prerequisites
-   Go 1.21+
-   PostgreSQL (running on default port 5432)
-   Redis (running on default port 6379)

### Running
1.  **Configure Database:** Ensure Postgres user `kimpay` exists or update `internal/database/db.go`.
2.  **Install Deps:** `go mod tidy`
3.  **Start:** `go run cmd/server/main.go`

## Endpoints

### GraphQL (`/graphql`)
Query your user data flexibly:
```graphql
query {
    user(id: 1) {
        username
        wallets {
            currency
            balance
        }
    }
}
```

### REST API
-   `POST /api/transactions/transfer`: Pushes job to Redis Queue (Async).
-   `GET /api/market/crypto`: Live cached data.
