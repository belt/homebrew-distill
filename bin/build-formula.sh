#!/usr/bin/env bash
# Build distill-strip-ansi from upstream source.
# Usage:
#   ./bin/build-formula.sh        # build at formula version tag
#   ./bin/build-formula.sh HEAD   # build from main branch
set -euo pipefail

if [ "${1:-}" = "HEAD" ]; then
  CLONE_ARGS=(--quiet --depth 1)
  LABEL="HEAD"
else
  VERSION=$(grep -oP '(?<=refs/tags/v)[0-9]+\.[0-9]+\.[0-9]+' Formula/distill-strip-ansi.rb | head -1)
  if [ -z "$VERSION" ]; then
    echo "err: could not extract version from formula" >&2
    exit 1
  fi
  CLONE_ARGS=(--quiet --depth 1 --branch "v${VERSION}")
  LABEL="v${VERSION}"
fi

WORKDIR=$(mktemp -d)
trap 'rm -rf "$WORKDIR"' EXIT

echo "building ${LABEL}..."
git clone "${CLONE_ARGS[@]}" \
  https://github.com/belt/distill-strip-ansi.git "$WORKDIR"
cargo build --quiet --release --manifest-path "$WORKDIR/Cargo.toml"
echo "ok: ${LABEL} built successfully"
