#!/usr/bin/env bash
# Run the same assertions as Formula/distill-strip-ansi.rb test block
# against cargo-built binaries from the upstream source.
set -euo pipefail

VERSION=$(grep -oP '(?<=refs/tags/v)[0-9]+\.[0-9]+\.[0-9]+' Formula/distill-strip-ansi.rb | head -1)
if [ -z "$VERSION" ]; then
  echo "err: could not extract version from formula" >&2
  exit 1
fi

WORKDIR=$(mktemp -d)
trap 'rm -rf "$WORKDIR"' EXIT

echo "building v${VERSION}..."
git clone --quiet --depth 1 --branch "v${VERSION}" \
  https://github.com/belt/distill-strip-ansi.git "$WORKDIR"
cargo build --quiet --release --manifest-path "$WORKDIR/Cargo.toml"

STRIP="$WORKDIR/target/release/strip-ansi"
DISTILL="$WORKDIR/target/release/distill-ansi"

# Same assertions as Formula test block:
# SGR (bold, green) + all 5 echoback threats (CSI 21t, CSI 6n,
# DCS DECRQSS, OSC 50, OSC 52) + OSC hyperlink + OSC title +
# Fe (Index, Reverse Index).  Dumb preset strips everything.
# shellcheck disable=SC2016  # $q is literal (DCS DECRQSS), not a variable
INPUT=$(printf '\033[1mBuild\033[0m \033[32m\xe2\x9c\x93\033[0m \033[21t\033[6n\033P$q"p\033\\\033]50;?\a\033]52;c;Cg==\a\033]8;;https://ci.dev\alog\033]8;;\a\033]0;title\a\033D\033M done')
OUTPUT=$(echo "$INPUT" | "$STRIP")
EXPECTED="Build ✓ log done"

if [ "$(echo "$OUTPUT" | xargs)" != "$EXPECTED" ]; then
  echo "err: strip-ansi output mismatch" >&2
  echo "  expected: $EXPECTED" >&2
  echo "  got:      $(echo "$OUTPUT" | xargs)" >&2
  exit 1
fi

# Version checks
"$STRIP" --version | grep -q "$VERSION" || { echo "err: strip-ansi --version mismatch" >&2; exit 1; }
"$DISTILL" --version | grep -q "$VERSION" || { echo "err: distill-ansi --version mismatch" >&2; exit 1; }

echo "ok: formula test assertions passed (v${VERSION})"
