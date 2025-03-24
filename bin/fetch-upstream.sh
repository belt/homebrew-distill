#!/usr/bin/env bash
# Fetch the latest upstream release tag and compute sha256.
# No brew required — uses GitHub API + curl + sha256sum.
set -euo pipefail

REPO="belt/distill-strip-ansi"

echo "fetching latest release from ${REPO}..."
LATEST=$(curl -sL "https://api.github.com/repos/${REPO}/releases/latest" \
  | grep -oP '"tag_name":\s*"\K[^"]+')

if [ -z "$LATEST" ]; then
  echo "err: could not determine latest release" >&2
  exit 1
fi

VERSION="${LATEST#v}"
TARBALL="https://github.com/${REPO}/archive/refs/tags/${LATEST}.tar.gz"

echo "latest: ${LATEST}"
echo "tarball: ${TARBALL}"
echo ""

SHA=$(curl -sL "$TARBALL" | sha256sum | cut -d' ' -f1)

echo "url \"${TARBALL}\""
echo "sha256 \"${SHA}\""
echo ""

# Compare with current formula
CURRENT=$(grep -oP '(?<=refs/tags/v)[0-9]+\.[0-9]+\.[0-9]+' Formula/distill-strip-ansi.rb | head -1)
if [ "$CURRENT" = "$VERSION" ]; then
  echo "formula already at v${VERSION} — no bump needed"
else
  echo "formula is at v${CURRENT} → update to v${VERSION}"
fi
