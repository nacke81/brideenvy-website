# BrideEnvy.com Development Commands
# Usage: make <target>

.PHONY: up down restart logs shell db-import db-export wp plugins-install lint lint-fix test setup

# Start all services
up:
	docker compose up -d

# Stop all services
down:
	docker compose down

# Restart all services
restart:
	docker compose down && docker compose up -d

# View WordPress container logs
logs:
	docker compose logs -f wordpress

# Open a bash shell in the WordPress container
shell:
	docker compose exec wordpress bash

# Import a database dump from db/dump.sql
db-import:
	docker compose run --rm wpcli db import /db/dump.sql

# Export the current database to db/dump.sql
db-export:
	docker compose run --rm wpcli db export /db/dump.sql

# Run wp-cli commands (usage: make wp CMD="plugin list")
wp:
	docker compose run --rm wpcli $(CMD)

# Install third-party plugins from plugins.txt
plugins-install:
	@while IFS= read -r plugin; do \
		[ -z "$$plugin" ] || [ "$${plugin:0:1}" = "#" ] && continue; \
		docker compose run --rm wpcli plugin install $$plugin --activate; \
	done < plugins.txt

# Run PHPCS lint
lint:
	php /c/php/composer lint

# Fix PHPCS violations
lint-fix:
	php /c/php/composer lint:fix

# Run PHPUnit tests
test:
	php /c/php/composer test

# Full local setup from scratch
setup: up
	@echo "Waiting for WordPress to initialize..."
	@sleep 10
	docker compose run --rm wpcli core install \
		--url=http://localhost:8080 \
		--title="BrideEnvy Local" \
		--admin_user=admin \
		--admin_password=admin \
		--admin_email=admin@brideenvy.local
	$(MAKE) plugins-install
	@echo ""
	@echo "Site ready at http://localhost:8080"
	@echo "phpMyAdmin at http://localhost:8081"
	@echo "Mailhog at http://localhost:8025"
