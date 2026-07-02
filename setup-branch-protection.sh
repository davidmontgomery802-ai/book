#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== GitHub Branch Protection Setup ===${NC}\n"

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed${NC}"
    echo -e "${YELLOW}Install it from: https://cli.github.com${NC}"
    echo ""
    echo "macOS (Homebrew):"
    echo "  brew install gh"
    echo ""
    echo "Linux (Ubuntu/Debian):"
    echo "  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "  echo 'deb [arch=\$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main' | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    echo "  sudo apt update"
    echo "  sudo apt install gh"
    echo ""
    echo "Windows (Chocolatey):"
    echo "  choco install gh"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo -e "${YELLOW}Not authenticated with GitHub CLI${NC}"
    echo "Authenticating now..."
    gh auth login
    
    if ! gh auth status &> /dev/null; then
        echo -e "${RED}Authentication failed${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✓ GitHub CLI authenticated${NC}\n"

# Function to setup branch protection
setup_branch_protection() {
    local repo=$1
    local branch=$2
    local require_approvals=$3
    
    echo -e "${BLUE}Setting up branch protection for $repo on branch '$branch'${NC}"
    
    # Create branch protection rule
    gh api \
        --method PUT \
        "/repos/$repo/branches/$branch/protection" \
        -f "required_pull_request_reviews[required_approving_review_count]=$require_approvals" \
        -F "required_pull_request_reviews[dismiss_stale_reviews]=true" \
        -F "required_pull_request_reviews[require_code_owner_reviews]=true" \
        -F "enforce_admins=true" \
        -F "require_linear_history=true" \
        -F "require_signed_commits=true" \
        -F "required_conversation_resolution=true" \
        -F "allow_force_pushes=false" \
        -F "allow_deletions=false" \
        2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Branch protection configured for $repo/$branch${NC}\n"
        return 0
    else
        echo -e "${RED}✗ Failed to configure branch protection${NC}\n"
        return 1
    fi
}

# Setup book repository
echo -e "${BLUE}--- Setting up 'book' repository ---${NC}\n"
setup_branch_protection "davidmontgomery802-ai/book" "master" 1

# Setup fhevm repository
echo -e "${BLUE}--- Setting up 'fhevm' repository ---${NC}\n"
setup_branch_protection "davidmontgomery802-ai/fhevm" "main" 2

# Verify setup
echo -e "${BLUE}Verifying branch protection rules...${NC}\n"

echo -e "${BLUE}📋 book repository (master):${NC}"
gh api "/repos/davidmontgomery802-ai/book/branches/master/protection" \
    -q '{approvals: .required_pull_request_reviews.required_approving_review_count, enforce_admins: .enforce_admins, signed_commits: .require_signed_commits}' 2>/dev/null && echo ""

echo -e "${BLUE}📋 fhevm repository (main):${NC}"
gh api "/repos/davidmontgomery802-ai/fhevm/branches/main/protection" \
    -q '{approvals: .required_pull_request_reviews.required_approving_review_count, enforce_admins: .enforce_admins, signed_commits: .require_signed_commits}' 2>/dev/null && echo ""

# Print summary
echo -e "${GREEN}=== Branch Protection Setup Complete! ===${NC}\n"
echo "Summary:"
echo "--------"
echo -e "${GREEN}✓${NC} davidmontgomery802-ai/book (master)"
echo "  - Requires 1 approval"
echo "  - Requires code owner reviews"
echo "  - Requires signed commits"
echo "  - Enforces for admins"
echo "  - Requires linear history"
echo ""
echo -e "${GREEN}✓${NC} davidmontgomery802-ai/fhevm (main)"
echo "  - Requires 2 approvals"
echo "  - Requires code owner reviews"
echo "  - Requires signed commits"
echo "  - Enforces for admins"
echo "  - Requires linear history"
echo ""
echo -e "${GREEN}All workflows and branch protection are now configured!${NC}"
