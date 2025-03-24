#!/usr/bin/env bash
# Lint formula Ruby files with rubocop using Homebrew's cops.
# Falls back to basic ruby -c syntax check if rubocop unavailable.
set -euo pipefail

if command -v rubocop >/dev/null 2>&1; then
  rubocop --format quiet Formula/*.rb
  echo "ok: tap syntax valid"
elif command -v ruby >/dev/null 2>&1; then
  for f in Formula/*.rb; do
    ruby -c "$f" >/dev/null
  done
  echo "ok: ruby syntax valid (rubocop not available for full lint)"
else
  echo "skip: neither rubocop nor ruby found"
  exit 0
fi
