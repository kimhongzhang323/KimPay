# KimPay Professional Backend

Enterprise-grade Go (Golang) backend for KimPay financial services.

## Architecture

This backend serves as a microservices-ready monolith (Modular Monolith) implementing:
-   **Clean Architecture:** (Handlers -> Services -> Repositories)
-   **Database:** **PostgreSQL** for ACID-compliant financial records.
-   **Blockchain Ledger:** Internal **SHA-256 Blockchain** mechanism to provide a tamper-proof audit trail of all transactions.
-   **Caching & Messaging:** **Redis** used for caching market data and implementing the Distributed Job Queue.
-   **API Protocols:** REST, GraphQL, gRPC.

## Services
-   **Auth Service:** JWT generation, bcrypt hashing.
-   **Wallet Service:** Multi-currency logic, PostgreSQL transactions.
-   **Blockchain Service:** Mining (PoW) and Block Validation logic.
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

### Blockchain (`/api/blockchain` - Protected)
View the immutable ledger:
```json
{
  "ledger_height": 5,
  "is_valid": true,
  "blocks": [...]
}
```

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
-   `POST /api/transactions/transfer`: Pushes job to Redis Queue (Async) -> Triggers Block Mining on success.
-   `GET /api/market/crypto`: Live cached data.
