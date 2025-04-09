# PR

## Summary

<!-- What does this PR do? Version bump, new formula, CI fix? -->

Closes #

## Commit Message

<!--
  Conventional commits — match the source project:
  feat(formula):  new formula or feature
  fix(formula):   formula correction
  chore(deps):    version bump (url + sha256)
  ci(deps):       GitHub Actions update
  docs:           README, SECURITY, templates
-->

## Checklist

- [ ] Commit message follows conventional commits
- [ ] `url` and `sha256` updated
      (`brew fetch --force --retry`)
- [ ] `brew install --build-from-source
      ./Formula/<formula>.rb`
- [ ] `brew test <formula>`
- [ ] `brew audit --strict <formula>`
- [ ] `brew livecheck <formula>` detects new version
