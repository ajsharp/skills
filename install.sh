#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for skill in "$repo_dir"/skills/*; do
  [[ -d "$skill" ]] || continue
  name="$(basename "$skill")"

  for target_root in "$HOME/.agents/skills" "$HOME/.claude/skills"; do
    mkdir -p "$target_root"
    target="$target_root/$name"

    if [[ -e "$target" && ! -L "$target" ]]; then
      echo "Refusing to replace non-symlink: $target" >&2
      exit 1
    fi

    ln -sfn "$skill" "$target"
    echo "$target -> $skill"
  done
done
