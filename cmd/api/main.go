package main

import (
	"log"
	"os"

	"github.com/sikozonpc/social/internal/env"
	"github.com/sikozonpc/social/internal/env/db"
	"github.com/sikozonpc/social/internal/env/store"
)

// const version = "0.0.1"

func init() {
	env.LoadEnv()
}
const version = "0.0.1"
func main() {
	cfg := config{
		addr: ":" + os.Getenv("PORT"),
		db: dbConfig{
		addr: os.Getenv("POSTGRES_CONN"),
			maxOpenConns :30,
			maxIdleConns: 30,
			maxIdleTime: "15m",
		},
		env: env.GetString("ENV", "development"),
		
	}
		
	db, err := db.New(
		cfg.db.addr,
		cfg.db.maxOpenConns,
		cfg.db.maxIdleConns,
		cfg.db.maxIdleTime,
	)

	if err != nil {
		log.Panic(err)
	}

	defer db.Close()
	  log.Println("database connection pool established")

store := store.NewStorage(db)

app := &application{
		config: cfg,
		store: store,
}

mux := app.mount()

log.Fatal(app.run(mux))
}





