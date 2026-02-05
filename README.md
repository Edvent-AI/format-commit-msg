# format-commit-msg

A git commit-msg hook that automatically prefixes commits with the ticket ID from your branch name.

## Installation

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/edvent-ai/format-commit-msg
    rev: v1.0.0
    hooks:
      - id: format-commit-msg
        stages: [commit-msg]
```

## Branch Naming

Branches must follow the format: `abc-123-description`

The hook extracts the ticket ID (`abc-123`) and prepends it to your commit message as `[ABC-123]`.

## Credits

Based on [bartoszmajsak's gist](https://gist.github.com/bartoszmajsak/1396344).
