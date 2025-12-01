include .env

MIGRATIONS_PATH := ./cmd/migrate/migrations

.PHONY: migration
migration:
	@migrate create -seq -ext sql -dir $(MIGRATIONS_PATH) $(filter-out $@,$(MAKECMDGOALS))

.PHONY: migrate-up
migrate-up:
	@echo "Running migrations UP..."
	@-migrate -path $(MIGRATIONS_PATH) -database "$(POSTGRES_CONN)" up || migrate -path $(MIGRATIONS_PATH) -database "$(POSTGRES_CONN)" force 1 && migrate -path $(MIGRATIONS_PATH) -database "$(POSTGRES_CONN)" up

.PHONY: migrate-down
migrate-down:
	@echo "Running migrations DOWN..."
	@-migrate -path $(MIGRATIONS_PATH) -database "$(POSTGRES_CONN)" down $(filter-out $@,$(MAKECMDGOALS)) || migrate -path $(MIGRATIONS_PATH) -database "$(POSTGRES_CONN)" force 1 && migrate -path $(MIGRATIONS_PATH) -database "$(POSTGRES_CONN)" down $(filter-out $@,$(MAKECMDGOALS))




# If database is dirty after failed migration, run the following commands in terminal to fix it:

# set POSTGRES_CONN=postgres://admin:adminpassword@localhost:5433/social?sslmode=disable
# echo %POSTGRES_CONN% postgres://admin:adminpassword@localhost:5433/social?sslmode=disable
# C:\Users\vedan\OneDrive\Desktop\GO-Project>migrate -path ./cmd/migrate/migrations -database "%POSTGRES_CONN%" version
# migrate -path ./cmd/migrate/migrations -database "%POSTGRES_CONN%" force 1
# C:\Users\vedan\OneDrive\Desktop\GO-Project>make migrate-up
# C:\Users\vedan\OneDrive\Desktop\GO-Project>make migrate-down
