# Contributing to homebrew-distill

Thank you for your interest in contributing. This project welcomes
contributions from everyone who respects our
[Code of Conduct](CODE_OF_CONDUCT.md).

## Quick Start

1. Fork the repo and clone your fork
2. Ensure you have Homebrew installed (macOS or Linux Homebrew):

   ```sh
   brew --version
   ```

3. Create a feature branch from `main`
4. Make your changes
5. Run the local validation suite:

   ```sh
   mise run tap:run-ci
   ```

   Or without mise:

   ```sh
   brew install --build-from-source ./Formula/distill-strip-ansi.rb
   brew test distill-strip-ansi
   brew audit --strict --formula Formula/distill-strip-ansi.rb
   ```

6. Open a pull request against `main`

## Version Bump Workflow

When a new upstream release of
[distill-strip-ansi](https://github.com/belt/distill-strip-ansi)
is published:

1. Fetch the new tarball hash:

   ```sh
   mise run tap:fetch-upstream
   ```

2. Update `Formula/distill-strip-ansi.rb` with the new `url`
   and `sha256`
3. Run the full validation:

   ```sh
   mise run tap:run-ci
   ```

4. Open a PR using the
   [PR template](.github/pull_request_template.md)

## Platform Requirements

This is a Homebrew tap — formula validation requires macOS or
Linux with [Homebrew](https://brew.sh) installed. The CI runs
on macOS (Intel + ARM) and Linux (Homebrew container).

## Reporting Bugs

Use the [Bug Report](https://github.com/belt/homebrew-distill/issues/new?template=bug_report.yml)
issue template. Include:

- The formula version
- Your OS and Homebrew version (`brew config`)
- Steps to reproduce
- Expected vs actual behavior

## Requesting Features

Use the [Feature Request](https://github.com/belt/homebrew-distill/issues/new?template=feature_request.yml)
issue template. Describe the use case and why existing
functionality does not cover it.

## Security Vulnerabilities

Do **not** open a public issue for security vulnerabilities.
See [SECURITY.md](SECURITY.md) for responsible disclosure
instructions.

## License

By contributing, you agree that your contributions will be
licensed under the same terms as the project:
[MIT OR Apache-2.0](LICENSE-MIT).
