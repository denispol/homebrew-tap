# homebrew-tap

Homebrew formulae for my projects.

## Install

    brew tap denispol/tap

Then:

    brew install procguard

Or directly:

    brew install denispol/tap/procguard

## Formulae

| Formula                                            | Description                                                                                             |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| [procguard](https://github.com/denispol/procguard) | Formally verified process supervisor for macOS. Memory limits, sleep-aware timeout, JSON output. 119KB. |

Both `procguard` and `timeout` commands are installed. Use `procguard` for wall-clock timing (survives sleep) or `timeout` for GNU-compatible active-time behavior.

### Migrating from darwin-timeout

The `darwin-timeout` formula has been renamed to `procguard`. To migrate:

```bash
brew uninstall darwin-timeout
brew install denispol/tap/procguard
```

## Update

    brew update && brew upgrade procguard
