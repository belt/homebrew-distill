# Security

## Reporting Formula Issues

If you find a security issue with the Homebrew
formula (e.g. incorrect sha256, compromised download
URL, build script injection), report via
[GitHub Security Advisories][tap-advisory].

Do not open a public issue for security vulnerabilities.

## Crate Security

For security issues in the `distill-strip-ansi` crate
itself (parser bugs, echoback bypass, threat detection
gaps), report to the [source repository][crate-advisory].

See the crate's [security model][crate-security] for
the full threat model and architectural defenses.

[tap-advisory]: https://github.com/belt/homebrew-distill/security/advisories/new
[crate-advisory]: https://github.com/belt/distill-strip-ansi/security/advisories/new
[crate-security]: https://github.com/belt/distill-strip-ansi/blob/main/SECURITY.md
