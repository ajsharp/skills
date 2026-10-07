# ajsharp skills

Personal agent skills.

## Skills

- `sss` — Shorten, summarize, and simplify a message.
- `distill-sentence` — Reduce the previous message to one sentence, or up to N sentences when given a number.
- `disk-cleanup` — Find disk-space cleanup candidates safely; inspect first and delete only with explicit approval.
- `asd-ste100` — Reminder to reply in ASD-STE100 Simplified Technical English: short, one action per step, ADHD-readable.

In Claude Code, invoke the latter with `/distill-sentence` or `/distill-sentence 3`. In Pi, use `/skill:distill-sentence` or `/skill:distill-sentence 3`.

## Install

Run:

```sh
./install.sh
```

This links each directory under `skills/` into both `~/.agents/skills/` and `~/.claude/skills/`.
