---
name: fast-code-review
description: Create a prioritized, read-only code-review map for a local diff, branch, pull request, or commit range, with exact lines, behavior risks, and high-value tests.
---

# Fast Code Review

Produce a compact review path that lets a human understand the consequential changes first. Optimize for review decisions, not diff coverage.

## Resolve the review scope

1. Honor an explicitly named PR, branch, commit, range, or patch.
2. Otherwise, use the current branch's PR base when `gh pr view` is available.
3. Without a PR, prefer the merge base with `origin/main`, then `main`, then `HEAD~1`.
4. State the chosen base. Keep uncommitted changes separate from a PR diff unless the user asks to include them.
5. Read applicable repository instructions. Read product or architecture guidance only when needed to explain a changed decision.

Remain read-only. Do not edit, format, stage, commit, push, comment, or update trackers.

## Build the semantic change map

Inventory before interpreting:

```bash
git status --short
git diff --find-renames --name-status <base>...HEAD
git diff --find-renames --stat <base>...HEAD
git diff --find-renames --unified=0 <base>...HEAD
```

Adapt the final range for a commit, staged diff, working tree, or supplied patch.

Then:

1. Group files by responsibility rather than directory order:
   - domain and product rules;
   - persistence, migrations, identity, and lifecycle;
   - scheduling, retries, concurrency, and side effects;
   - API, integration, and UI boundaries;
   - tests and operational documentation;
   - generated files, lockfiles, snapshots, and mechanical noise.
2. Trace consequential changes to their callers, consumers, persisted state, and tests with narrow `rg` searches.
3. Inspect complete semantic units, not isolated changed lines. Use line-numbered excerpts such as:

```bash
nl -ba path/to/file | sed -n '<start>,<end>p'
```

4. Extend each range to cover the complete method, component, migration, query, or state transition needed to review the behavior.
5. Verify that every reported line range matches the current file after all edits. For deleted-only code, label the range as base-side or deleted.

## Rank what the human should review

Choose three to eight primary targets. Rank actual changed behavior using these lenses:

1. Security, authorization, money, destructive operations, and irreversible data effects.
2. Schema changes, identity, uniqueness, deduplication, idempotency, transactions, concurrency, retries, and failure recovery.
3. State transitions, timestamps, timezones, ordering, caching, event delivery, and lifecycle ownership.
4. Product eligibility, classification, grouping, limits, fallbacks, and user-visible policy.
5. External integration contracts and API compatibility.
6. UI state and presentation that can change or conceal behavior.

Do not rank a file highly merely because it is large. Prefer the smallest semantic range that determines the behavior.

## Describe each target substantively

For every primary target, include:

- a clickable file path with an inclusive current line range;
- the concrete behavior change in plain language;
- why it matters and the invariant the reviewer should protect;
- the most important edge case or quality question;
- the corresponding test range when one exists.

Avoid descriptions such as “updates the service” or “adds tests.” Explain the decision, state transition, query, failure path, or before/after behavior.

Use links whose target points to the first line and whose label contains the full range, for example:

```markdown
[app/services/example.rb:42–79](/absolute/path/app/services/example.rb:42)
```

## Produce the review guide

Lead with an **If you only have 10 minutes** section containing the three to five highest-value targets in review order. A compact table usually works best:

| Priority | File and lines | What changed | Quality focus |
|---|---|---|---|

Follow only with useful supporting sections:

- **Critical flow**: a short sequence when behavior crosses multiple components.
- **High-value tests**: three to six ranges that encode the important contract and edge cases.
- **Secondary skim**: serializers, renderers, UI, docs, or compatibility paths worth checking after the core.
- **Safe to skip**: generated schema output, lockfile churn, snapshots, formatting, or unrelated files, with a brief reason.
- **Scope note**: chosen base and any excluded working-tree changes.

Keep the guide concise enough to scan once. Do not enumerate every changed file or hunk.

## Preserve review integrity

- Distinguish confirmed behavior from a reviewer question or suspected risk.
- Do not claim the change is correct, tested, or ready to ship unless current evidence establishes that separately.
- Do not turn green tests into proof that important invariants are covered; identify what the tests actually demonstrate.
- Do not hide migrations, configuration, retry paths, or compatibility code merely because they are small.
- If the user also asks for a readiness verdict or defect discovery, run the repository's adversarial review workflow separately after producing this map.
