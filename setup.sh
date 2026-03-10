#!/bin/bash
# FormGuard Site - GitHub Pages Setup Script
# Run this after authenticating gh: gh auth login

set -e

cd "$(dirname "$0")"

# Create the GitHub repo
echo "Creating GitHub repository..."
gh repo create formguard-site --public --source=. --remote=origin --push

# Enable GitHub Pages on main branch
echo "Enabling GitHub Pages..."
gh api repos/{owner}/{repo}/pages \
  --method POST \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || \
gh api repos/{owner}/{repo}/pages \
  --method PUT \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || true

echo ""
echo "✅ Done! Your site should be available at:"
OWNER=$(gh api user --jq '.login')
echo "  https://${OWNER}.github.io/formguard-site/"
echo "  https://${OWNER}.github.io/formguard-site/privacy.html"
echo "  https://${OWNER}.github.io/formguard-site/terms.html"
echo "  https://${OWNER}.github.io/formguard-site/support.html"
echo ""
echo "Note: It may take 1-2 minutes for GitHub Pages to deploy."
