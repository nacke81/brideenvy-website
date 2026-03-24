# BrideEnvy.com

WordPress/WooCommerce wedding dress e-commerce site. This repo tracks wp-content only (themes, custom plugins, mu-plugins). WordPress core is NOT in the repo.

## Architecture

- **Repo scope:** wp-content/themes/, wp-content/plugins/ (custom only), wp-content/mu-plugins/
- **Third-party plugins:** NOT tracked in git. Listed in plugins.txt, installed via wp-cli.
- **Local dev:** Docker Compose (WordPress + MySQL 8.0 + phpMyAdmin + Mailhog)
- **Hosting:** Cloudways Flexible (production: brideenvy.com, staging available)
- **Deploy:** GitHub Actions rsync over SSH to Cloudways

## Coding Standards

- Follow WordPress Coding Standards (WPCS)
- Tabs for indentation (not spaces)
- PHPDoc on every public method
- Guard clause at top of every PHP file: `if ( ! defined( 'ABSPATH' ) ) { exit; }`
- Class files named `class-{slug}.php`
- Text domain: `brideenvy`

## Commands

- Start local site: `make up` (then visit http://localhost:8080)
- Stop local site: `make down`
- Lint: `make lint` or `composer lint`
- Fix lint: `make lint-fix` or `composer lint:fix`
- Test: `make test` or `composer test`
- Test single: `composer test -- --filter=test_name`
- WP-CLI: `make wp CMD="plugin list"`
- Import DB: place dump in db/dump.sql, then `make db-import`
- Export DB: `make db-export`
- Install third-party plugins: `make plugins-install`

## Branching & Deployment

- `main` branch is always deployable to production
- `staging` branch deploys to the staging environment
- Feature branches: `feature/*`, `fix/*`, `custom-plugin/*`
- Never push directly to main; always use a PR
- CI must pass (lint + tests) before merge
- Squash merge PRs to keep history clean

## Key Directories

- `wp-content/themes/` -- Custom theme
- `wp-content/plugins/` -- Custom plugins only (third-party gitignored)
- `wp-content/mu-plugins/` -- Must-use plugins (local dev config, etc.)
- `tests/` -- PHPUnit test suite
- `.github/workflows/` -- CI and deploy pipelines
- `db/` -- Database dumps (gitignored)

## Docker Services

| Service    | URL                    | Purpose          |
|------------|------------------------|------------------|
| WordPress  | http://localhost:8080  | Local site       |
| phpMyAdmin | http://localhost:8081  | DB management    |
| Mailhog    | http://localhost:8025  | Email testing    |
| MySQL      | localhost:3306         | Database         |

## Adding a New Custom Plugin

1. Create directory under `wp-content/plugins/your-plugin-name/`
2. Write tests in `tests/`
3. Run `make lint` and `make test` before committing

## Adding a Third-Party Plugin

1. Add the slug to `plugins.txt`
2. Add its directory to `.gitignore`
3. Add a PHPCS exclude pattern in `.phpcs.xml.dist`
4. Run `make plugins-install` locally
5. Install it on staging/production via Cloudways dashboard or wp-cli over SSH
