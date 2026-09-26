#!/usr/bin/env bash
# Lint formula Ruby files using Homebrew's style rules.
# Falls back to basic ruby -c syntax check if Homebrew is unavailable.
set -euo pipefail

if command -v brew >/dev/null 2>&1
then
  brew style Formula/*.rb
  echo "ok: tap syntax valid"
elif command -v ruby >/dev/null 2>&1
then
  for f in Formula/*.rb
  do
    ruby -c "${f}" >/dev/null
  done
  echo "ok: ruby syntax valid (Homebrew not available for full lint)"
else
  echo "skip: neither Homebrew nor Ruby found"
  exit 0
fi
