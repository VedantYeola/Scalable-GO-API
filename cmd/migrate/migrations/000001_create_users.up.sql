CREATE EXTENSION IF NOT EXISTS citext;

CREATE TABLE IF NOT EXISTS users(
   id bigserial PRIMARY KEY,
--    first_name VARCHAR(255) NOT NULL,
--    last_name VARCHAR(255) NOT NULL,
   email citext UNIQUE NOT NULL,
   username VARCHAR(225) UNIQUE NOT NULL,
   password bytea NOT NULL,
   created_at timestamp (0) with time zone NOT NULL DEFAULT NOW()
);


-- command for up 
--  migrate -path ./cmd/migrate/migrations -database "postgres://admin:adminpassword@localhost:5433/social?sslmode=disable" up
