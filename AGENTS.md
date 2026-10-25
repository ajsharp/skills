# Agent instructions

## Project

This repository contains personal agent skills. Each skill lives in
`skills/<skill-name>/SKILL.md`.

- `README.md` lists the skills and installation instructions.
- `install.sh` links skill directories into `~/.agents/skills/` and
  `~/.claude/skills/`.

## Editing skills

- Read the existing skill before changing it.
- Give each `SKILL.md` YAML frontmatter with `name` and `description`.
- Match the skill name to its directory. Describe when the skill should run.
- Write concise, actionable instructions in plain language.
- Keep supporting files inside the skill directory and reference them from
  `SKILL.md`.
- Update `README.md` when adding or removing a skill.
- Reuse existing guidance where practical. `skills/sss/SKILL.md` contains the
  repository's shorten, summarize, and simplify guidance.
- Do not implement future ideas until the user asks to proceed.

## Verification and safety

- Check changed Markdown for clear instructions and valid local paths.
- Run `git diff --check` before finishing.
- For installer changes, run `bash -n install.sh`. Test installation with a
  temporary `HOME`, not the user's real skill directories.
- Preserve unrelated working-tree changes. Stage only files changed for the
  current task.
