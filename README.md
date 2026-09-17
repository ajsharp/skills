# ajsharp skills

Personal agent skills.

## Skills

- `sss` — Shorten, summarize, and simplify a message.
- `distill-sentence` — Reduce the previous message to one sentence, or exactly N sentences when given a number.

In Claude Code, invoke the latter with `/distill-sentence` or `/distill-sentence 3`. In Pi, use `/skill:distill-sentence` or `/skill:distill-sentence 3`.

## Install

Run:

```sh
./install.sh
```

This links each directory under `skills/` into both `~/.agents/skills/` and `~/.claude/skills/`.
