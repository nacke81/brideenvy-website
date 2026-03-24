#!/usr/bin/env bash
set -euo pipefail

# Deploy custom wp-content to Cloudways via rsync.
# Usage: deploy.sh user@host /remote/path/to/public_html

REMOTE="$1"
REMOTE_PATH="$2"

RSYNC_OPTS="-avz --delete --exclude='.git' --exclude='node_modules' --exclude='vendor' --exclude='tests' --exclude='*.log'"

# Deploy themes
echo "Deploying themes..."
rsync $RSYNC_OPTS ./wp-content/themes/ "${REMOTE}:${REMOTE_PATH}/wp-content/themes/"

# Deploy custom plugins (only ones tracked in git)
echo "Deploying custom plugins..."
for plugin in wp-content/plugins/*/; do
	plugin_name=$(basename "$plugin")
	echo "  -> ${plugin_name}"
	rsync $RSYNC_OPTS "./wp-content/plugins/${plugin_name}/" "${REMOTE}:${REMOTE_PATH}/wp-content/plugins/${plugin_name}/"
done

# Deploy mu-plugins
echo "Deploying mu-plugins..."
rsync $RSYNC_OPTS ./wp-content/mu-plugins/ "${REMOTE}:${REMOTE_PATH}/wp-content/mu-plugins/"

echo "Deploy complete."
