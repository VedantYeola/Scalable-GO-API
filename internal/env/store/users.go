package store

import (
	"context"
	"database/sql"
	// "os/user"
	// "github.com/pelletier/go-toml/query"
)

type User struct {
	ID        int64  `json:"id"`
	Username   string `json:"username"`
    // first_name string `json:"first_name"`
	// last_name  string `json:"last_name"`
	Email      string `json:"email"`
	Password   string `json:"-"`
	CreatedAt  string `json:"created_at"`
}

type UsersStore struct {
	db *sql.DB
}

func (s *UsersStore) Create(ctx context.Context, user *User) error {
	query := `
	INSERT INTO users (username, password, email) 
	VALUES ($1, $2, $3) RETURNING id, created_at
	`
	err := s.db.QueryRowContext(
		ctx,
		query,
		user.Username,
		user.Password,
		user.Email,
	).Scan(
		&user.ID,
		&user.CreatedAt,
	)
	if err != nil {
		return err
}
	return nil
}