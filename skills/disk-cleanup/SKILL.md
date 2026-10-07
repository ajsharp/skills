---
name: disk-cleanup
description: Find safe ways to reclaim local disk space. Use when asked to inspect disk usage, clean caches, review large project folders, node_modules, .next build output, simulator data, or agent worktrees. Defaults to reporting candidates; delete only what the user explicitly approves.
---

# Disk cleanup

Help the user reclaim disk space without losing source, work, or useful local state.

## Safety rules

- **Inspect first; do not delete by default.** A request to find or review cleanup candidates is not permission to remove them.
- Delete only targets the user explicitly approved. If scope or consequences are unclear, list the exact paths and sizes and ask first.
- Never remove source, uncommitted work, Git repositories, whole worktrees, project directories, user documents, or unknown application data as “cleanup.”
- Treat `node_modules` as regenerable, but check the project lockfile/package manager and confirm the directory is not in use before removal. Reinstall may take time and can fail offline.
- `.next` is generated build output and often regenerable, but a running dev/build process may be using it. Check before removal.
- App caches, package caches, simulator data, browser profiles, models, and runtime downloads can contain useful state or take time/bandwidth to recreate. Explain the tradeoff.
- Prefer the owning tool's cleanup command over manually deleting internal files. Never use broad `rm -rf` globs or follow symlinks while measuring/deleting.
- After any approved cleanup, verify the target is gone and report the before/after free space.

## Inspection workflow

1. Establish current free space with `df -h /` (or the relevant volume).
2. Measure likely areas without changing them. Use `du -sh` for named directories and `find` to discover generated directories; quote paths and handle spaces safely.
3. For project roots, report both individual large generated directories and the containing project/worktree. Nested worktrees may overlap with their parent totals, so do not add those figures together.
4. Rank candidates by reclaimable size and risk. Distinguish generated build output from dependencies, package caches, models, app state, and source/assets.
5. Present exact paths, sizes, likely impact, and a safe next step. Ask the user which cleanup they authorize if they requested action but did not specify targets.
6. Clean only approved targets, using a narrow command. Re-measure afterward.

## Useful read-only commands

```sh
df -h /
# Find generated directories; prune each match so it doesn't scan its contents.
find "$HOME/code" "$HOME/.codex/worktrees" \
  -type d \( -name node_modules -o -name .next \) -prune -print0 2>/dev/null |
  xargs -0 du -sh 2>/dev/null | sort -h
# Top-level project totals (may include nested worktrees; don't sum overlapping totals).
du -sh "$HOME"/code/* "$HOME"/.codex/worktrees/* 2>/dev/null | sort -h | tail -40
```

## Common candidates and caveats

- **`.next`**: generated Next.js build/cache output; usually safe to regenerate when the project is stopped.
- **`node_modules`**: installed dependencies; restore with the project’s package manager and lockfile. Avoid deleting while tooling is running.
- **Unavailable Xcode simulators**: `xcrun simctl list devices unavailable` is a read-only inventory. If approved, `xcrun simctl delete unavailable` removes only unavailable simulator devices; verify available space afterward.
- **Package-manager caches**: clear only through the package manager's own command after explaining that packages may need to be fetched again.
- **Git/worktree data**: do not remove manually. Ask before pruning worktrees; verify the worktree is merged/clean and use the VCS/tool's supported prune command.
- **Large repository folders**: inspect before classifying. Large `.git`, assets, generated SDK/toolchain caches, databases, and Terraform state are not automatically safe to remove.
