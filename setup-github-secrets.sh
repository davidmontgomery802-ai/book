#!/bin/bash

# GitHub Secrets Setup Script
# Sets up secrets needed for deployments and integrations

set -e

colors=(
    [green]='\033[0;32m'
    [blue]='\033[0;34m'
    [red]='\033[0;31m'
    [yellow]='\033[1;33m'
    [reset]='\033[0m'
)

log() {
    echo -e "${colors[$2]:-${colors[reset]}}$1${colors[reset]}"
}

log "\n=== GitHub Secrets Setup ===" "blue"
log "This script will help you set up secrets for your GitHub repositories\n" "blue"

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    log "❌ Error: GitHub CLI (gh) is not installed" "red"
    log "Install from: https://cli.github.com" "yellow"
    exit 1
fi

# Check authentication
if ! gh auth status &> /dev/null; then
    log "Authenticating with GitHub..." "blue"
    gh auth login
fi

log "✓ GitHub CLI authenticated\n" "green"

REPO_OWNER="davidmontgomery802-ai"

# Function to add a secret
add_secret() {
    local repo=$1
    local secret_name=$2
    local secret_value=$3
    
    if [ -z "$secret_value" ]; then
        log "Skipping $secret_name (no value provided)" "yellow"
        return
    fi
    
    log "Adding secret: $secret_name to $repo..." "blue"
    echo "$secret_value" | gh secret set "$secret_name" --repo "$repo"
    log "✓ $secret_name added" "green"
}

# Deployment Secrets
log "\n=== Deployment Secrets ===" "blue"
log "These are needed for automated deployments\n" "yellow"

read -sp "Enter GitHub Pages Deploy Token (or press Enter to skip): " GITHUB_PAGES_TOKEN
echo
if [ -n "$GITHUB_PAGES_TOKEN" ]; then
    add_secret "$REPO_OWNER/book" "GITHUB_PAGES_TOKEN" "$GITHUB_PAGES_TOKEN"
fi

# Stripe Integration Secrets
log "\n=== Stripe Integration (Optional) ===" "blue"
log "Needed if using Stripe for payments\n" "yellow"

read -p "Enter Stripe API Key (or press Enter to skip): " STRIPE_API_KEY
if [ -n "$STRIPE_API_KEY" ]; then
    add_secret "$REPO_OWNER/book" "STRIPE_API_KEY" "$STRIPE_API_KEY"
fi

read -p "Enter Stripe Webhook Secret (or press Enter to skip): " STRIPE_WEBHOOK_SECRET
if [ -n "$STRIPE_WEBHOOK_SECRET" ]; then
    add_secret "$REPO_OWNER/book" "STRIPE_WEBHOOK_SECRET" "$STRIPE_WEBHOOK_SECRET"
fi

# Mailchimp Integration Secrets
log "\n=== Mailchimp Integration (Optional) ===" "blue"
log "Needed if using Mailchimp for email campaigns\n" "yellow"

read -p "Enter Mailchimp API Key (or press Enter to skip): " MAILCHIMP_API_KEY
if [ -n "$MAILCHIMP_API_KEY" ]; then
    add_secret "$REPO_OWNER/book" "MAILCHIMP_API_KEY" "$MAILCHIMP_API_KEY"
fi

read -p "Enter Mailchimp Server Prefix (or press Enter to skip): " MAILCHIMP_SERVER_PREFIX
if [ -n "$MAILCHIMP_SERVER_PREFIX" ]; then
    add_secret "$REPO_OWNER/book" "MAILCHIMP_SERVER_PREFIX" "$MAILCHIMP_SERVER_PREFIX"
fi

# PayPal Integration Secrets
log "\n=== PayPal Integration (Optional) ===" "blue"
log "Needed if using PayPal for payments\n" "yellow"

read -p "Enter PayPal Client ID (or press Enter to skip): " PAYPAL_CLIENT_ID
if [ -n "$PAYPAL_CLIENT_ID" ]; then
    add_secret "$REPO_OWNER/book" "PAYPAL_CLIENT_ID" "$PAYPAL_CLIENT_ID"
fi

read -sp "Enter PayPal Client Secret (or press Enter to skip): " PAYPAL_CLIENT_SECRET
echo
if [ -n "$PAYPAL_CLIENT_SECRET" ]; then
    add_secret "$REPO_OWNER/book" "PAYPAL_CLIENT_SECRET" "$PAYPAL_CLIENT_SECRET"
fi

# QuickBooks Integration Secrets
log "\n=== QuickBooks Integration (Optional) ===" "blue"
log "Needed if syncing with QuickBooks Online\n" "yellow"

read -p "Enter QuickBooks Realm ID (or press Enter to skip): " QUICKBOOKS_REALM_ID
if [ -n "$QUICKBOOKS_REALM_ID" ]; then
    add_secret "$REPO_OWNER/book" "QUICKBOOKS_REALM_ID" "$QUICKBOOKS_REALM_ID"
fi

read -p "Enter QuickBooks Client ID (or press Enter to skip): " QUICKBOOKS_CLIENT_ID
if [ -n "$QUICKBOOKS_CLIENT_ID" ]; then
    add_secret "$REPO_OWNER/book" "QUICKBOOKS_CLIENT_ID" "$QUICKBOOKS_CLIENT_ID"
fi

read -sp "Enter QuickBooks Client Secret (or press Enter to skip): " QUICKBOOKS_CLIENT_SECRET
echo
if [ -n "$QUICKBOOKS_CLIENT_SECRET" ]; then
    add_secret "$REPO_OWNER/book" "QUICKBOOKS_CLIENT_SECRET" "$QUICKBOOKS_CLIENT_SECRET"
fi

# Verify secrets
log "\n=== Verifying Secrets ===" "blue"

log "\nSecrets in $REPO_OWNER/book:" "blue"
gh secret list --repo "$REPO_OWNER/book" || log "No secrets found" "yellow"

log "\n✅ Secrets setup complete!" "green"
log "\nYou can now use these secrets in your GitHub Actions workflows:" "blue"
log "Example: \${{ secrets.STRIPE_API_KEY }}" "yellow"

log "\nTo update a secret, run:" "blue"
log "echo 'new_value' | gh secret set SECRET_NAME --repo $REPO_OWNER/book" "yellow"

log "\nTo view all available secrets:" "blue"
log "gh secret list --repo $REPO_OWNER/book" "yellow"
