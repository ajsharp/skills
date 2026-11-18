---
name: next-cache-cleanup
description: Find, measure, and safely clear regenerable Next.js .next/cache directories across code repos and worktrees. Use when build caches consume disk space or when asked to inventory or clean Next.js caches.
---

# Next.js cache cleanup

Find and clean only Next.js generated cache directories. These can be large, especially Webpack client/server production packs, and each checkout/worktree maintains its own cache. Cache contents are regenerable, but a running Next.js process may use them.

## Safety

- Default to read-only inventory. Delete only after the user explicitly approves the scope.
- Never delete a whole repository, worktree, `.next` directory, `node_modules`, or source data when the request is to clear caches. Target only the exact `.next/cache` directories identified.
- Before deletion, inspect running Next.js processes and their working directories. Skip caches belonging to active `next dev`, `next build`, or `next start` processes. Ask before stopping a process or deleting an in-use cache.
- Do not assume a Claude/Codex worktree is inactive because it is clean or unlocked. Check the process and path.
- Use null-delimited paths and quote variables; do not use broad `rm -rf` globs or follow symlinks.
- Verify each requested cache is gone and report disk space before/after. Explain that builds may be slower on the next run.

## Inventory

`rg` is useful for finding source/config references, but `.next` is commonly ignored and `rg --no-ignore --files` can enumerate huge cache contents. Use `find` to discover cache directories and prune each match so it does not traverse the cache contents.

```sh
find "$HOME/code" \
  \( -type d \( -name .git -o -name node_modules \) -prune \) -o \
  \( -type d -path '*/.next/cache' -prune -print0 \) |
  xargs -0 -n1 du -sh 2>/dev/null | sort -h
```

Add other explicit roots, such as `"$HOME/.codex/worktrees"`, if requested. Check parent worktree/repository totals separately; nested worktrees can make totals overlap.

## Check for active Next.js processes

On macOS, list likely active Next.js commands and inspect each server/build process's current directory. Ignore detached telemetry-flush subprocesses; they do not serve or build the app.

```sh
ps -axo pid=,ppid=,command= | grep -E '[n]ext (dev|build|start)|[n]ext-server'
lsof -a -p PID -d cwd -Fn 2>/dev/null
```

Match each process's working directory to the repository/worktree containing the cache. If uncertain whether it is active, skip it and ask.

## Approved cleanup

After the user approves the listed targets and no active process uses them, remove only each exact cache path:

```sh
cache='/absolute/repository/path/.next/cache'
[ -d "$cache" ] && rm -rf "$cache"
```

Re-run the inventory to verify removal, then check `df -h /`. Do not remove `.next/server`, `.next/static`, `.next/dev`, or the parent `.next` unless the user explicitly asks for the broader generated output and its use has been checked.
