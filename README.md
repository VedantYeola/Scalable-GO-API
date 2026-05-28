# 🚀 Scalable Go API

[![Go Version](https://img.shields.io/badge/Go-1.22+-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://golang.org)
[![Docker](https://img.shields.io/badge/Docker-enabled-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com)
[![Architecture](https://img.shields.io/badge/Architecture-Clean--Layers-orange?style=for-the-badge)](#-system-architecture)

A highly performant, production-ready REST API engineered in Go. Designed for massive throughput, ultra-low latency, and decoupled testing environments following Clean Architecture guidelines.

---

## 🏗️ System Architecture

This project strictly splits technical drivers (like routing frameworks or databases) away from core domain logic. GitHub will render the vector flowchart below automatically:

```mermaid
graph TD
    Client[📱 Client / Frontend] -->|HTTP Request| Proxy[🛡️ Reverse Proxy / Nginx]
    Proxy -->|Load Balances| API[🐹 Go API Cluster]
    
    subgraph Go Application Server
        API --> Middleware{🔒 Middleware Layer}
        Middleware -->|Passes Auth/Rate Limits| Handlers[🎮 HTTP Handlers/Controllers]
        Handlers -->|Invokes Business Logic| Services[⚙️ Domain Services]
        Services -->|Queries Abstract Interfaces| Repo[🗄️ Repository Layer]
    end

    Repo -->|Read/Write Operations| DB[(💾 Primary DB PostgreSQL)]
    Repo -.->|Cache Read/Write| Redis[(⚡ Cache Layer Redis)]

    style Go Application Server fill:#f9f9f9,stroke:#333,stroke-width:2px
    style API fill:#00ADD8,stroke:#333,stroke-width:1px,color:#fff




✨ Features & Core Tech Stack
⚡ High Performance: Utilizes Go's lightweight concurrency paradigm (Goroutines) for efficient resource consumption.

🛡️ Secure Middleware: Pre-configured with JWT verification, strict CORS rule scopes, and IP-based rate limiting.

🗃️ Interface-driven Storage: Decoupled repository patterns making database components 100% mockable for unit testing.

🐳 Containerized & Cloud Ready: Multi-stage production Dockerfile keeps image sizes lean.

🪵 Graceful Shutdowns: Intercepts SIGINT/SIGTERM to safely finish active connection jobs before killing the service.


.
├── cmd/
│   └── api/             # Main application entry point (main.go)
├── internal/
│   ├── config/          # Environment configuration loading parses
│   ├── database/        # Storage driver setups & connection pooling
│   ├── handlers/        # HTTP handlers (handles request inputs/responses)
│   ├── middleware/      # Global hooks (Auth, Request Logging, Rate Limiting)
│   ├── models/          # Schema entities & structural representations
│   ├── repository/      # Raw database query manipulations
│   └── services/        # Pure, isolated business logic engine operations
├── docker-compose.yml   # Multi-container infrastructure layouts
└── Dockerfile           # Optimized multi-stage deployment build steps


🚀 Getting Started
Prerequisites
Go (v1.22 or higher)

Docker & Docker Compose


Quick Deployment
1.Clone & Navigate

Bash
   git clone [https://github.com/VedantYeola/Scalable-GO-API.git](https://github.com/VedantYeola/Scalable-GO-API.git)
   cd Scalable-GO-API

2.Environment Variables
cp .env.example .env


3.Spin Up Infrastructure & Server
docker-compose up --build -d

4.Alternative Local Development Run
# Boot databases first
   docker-compose up -d database cache
   
   # Download module chains & run app
   go mod tidy
   go run cmd/api/main.go


📄 License
Distributed under the MIT License. See LICENSE for details.

⚡ Built with passion by Vedant Yeola
