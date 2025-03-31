# Belt Distill

Homebrew tap for [distill-strip-ansi][gh] — strip
ANSI escape sequences from byte streams, fast and
security-aware.

## Install

```sh
brew install belt/distill/distill-strip-ansi
```

Or tap first:

```sh
brew tap belt/distill
brew install distill-strip-ansi
```

Or in a [`Brewfile`](https://docs.brew.sh/Manpage#bundle-subcommand):

```ruby
tap "belt/distill"
brew "distill-strip-ansi"
```

## Also Available Via

- **cargo**: `cargo install distill-strip-ansi`
  ([crates.io][distill-strip-ansi-crate])

### Crate Quick Start

```sh
# Strip all ANSI from build output
cargo build --color=always 2>&1 | strip-ansi

# Save clean log
docker build . 2>&1 | strip-ansi > build.log

# Detect ANSI sequences (exit 1 if found)
strip-ansi --check < input.txt
```

See the [source repo][gh] for full CLI reference,
presets, security model, and library usage.

## Why distill-strip-ansi?

What + how it does. What + how others do.

- [Ecosystem comparison] — `strip-ansi-escapes`,
  `fast-strip-ansi`, `console`, `distill-strip-ansi`
- [Benchmarks] — Criterion.rs results across the
  Rust ANSI stripping ecosystem
- [Security model] — threat model, echoback defense,
  preset security properties
- [CVE mitigation] — per-CVE defense matrix for
  escape injection, echoback, terminal DoS
- [Terminal presets] — graduated capability levels
  from `dumb` to `full`
- [Color transforms] — truecolor to 256 to 16 to
  greyscale to mono depth reduction
- [Unicode normalization] — homograph defense for
  fullwidth, math bold, circled, ligatures
- [Distilled Design] — 1-byte state machine, SIMD scanning,
  zero-alloc architecture

## Contributing

```sh
brew install --build-from-source ./Formula/distill-strip-ansi.rb
brew test distill-strip-ansi
brew audit --strict distill-strip-ansi
```

See the [PR template](.github/pull_request_template.md) for
the version bump checklist.

## Security

See [SECURITY.md](SECURITY.md).

## Documentation

- `brew help`, `man brew` or check
  [Homebrew's documentation](https://docs.brew.sh).
- `strip-ansi --help`, `man strip-ansi` or check
  [distill-strip-ansi's documentation][distill-strip-ansi-docs]

## References

[gh]: https://github.com/belt/distill-strip-ansi
[distill-strip-ansi-docs]: https://github.com/belt/distill-strip-ansi/doc
[distill-strip-ansi-crate]: https://crates.io/crates/distill-strip-ansi
[Ecosystem comparison]: https://github.com/belt/distill-strip-ansi/blob/main/doc/ECOSYSTEM.md
[Benchmarks]: https://github.com/belt/distill-strip-ansi/blob/main/doc/BENCHMARKS.md
[Security model]: https://github.com/belt/distill-strip-ansi/blob/main/SECURITY.md
[CVE mitigation]: https://github.com/belt/distill-strip-ansi/blob/main/doc/CVE-MITIGATION.md
[Terminal presets]: https://github.com/belt/distill-strip-ansi/blob/main/doc/PRESETS.md
[Color transforms]: https://github.com/belt/distill-strip-ansi/blob/main/doc/COLOR-TRANSFORMS.md
[Unicode normalization]: https://github.com/belt/distill-strip-ansi/blob/main/doc/UNICODE-NORMALIZATION.md
[Design]: https://github.com/belt/distill-strip-ansi/blob/main/doc/DESIGN.md

## License

[Apache-2.0](LICENSE-APACHE) or [MIT](LICENSE-MIT) at your option.
