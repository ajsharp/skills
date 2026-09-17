---
name: sss
description: Shorten, Summarize, Simplify long or over-explanatory messages into ADHD-friendly, busy-person-readable output. Use when the user asks to “sss”, “shorten summarize simplify”, condense, tighten, make skimmable, make ADHD-friendly, reduce verbosity, extract the important parts, or rewrite a long LLM answer/email/document so it is easier to understand and act on quickly.
---

# SSS: Shorten, Summarize, Simplify

Transform long, over-explained text into something a busy, distractible reader can actually use.

## Core Rule

Optimize for **fast comprehension and action**, not completeness.

Preserve meaning, decisions, caveats, and action items. Remove filler, repetition, hedging, throat-clearing, generic encouragement, and unnecessary explanation.

## Default Output Shape

Use this structure unless the user asks otherwise:

```markdown
## Short version
1–3 sentences with the main point.

## Key points
- Important fact/decision
- Important caveat/risk
- Important context only if needed

## What to do next
- Concrete next action
- Optional follow-up action
```

If the source text is simple, skip headings and use 3–5 bullets.

## Rewrite Guidelines

- Lead with the answer.
- Use short sentences.
- Prefer bullets over paragraphs.
- Keep paragraphs to 1–3 lines.
- Delete meta-commentary like “Great question,” “It’s important to note,” and “In conclusion.”
- Replace vague language with concrete language.
- Keep only caveats that change a decision.
- Combine duplicate points.
- Preserve numbers, deadlines, names, commands, file paths, URLs, and explicit asks.
- Do not add new claims unless clearly labeled as interpretation.

## Plain-Language Rule — Mandatory

**Do not use jargon, buzzwords, corporate language, or recognizable LLM phrasing. This is a hard requirement, not a preference.**

- Use plain, natural language that a knowledgeable person would actually say.
- Replace jargon with common words. If a technical term is necessary, explain it briefly the first time.
- Never preserve jargon merely because it appeared in the source; rewrite it unless exact wording is required for accuracy.
- Remove canned LLM transitions and filler such as “delve into,” “navigate the complexities,” “in today’s landscape,” “it is worth noting,” “robust,” “seamless,” “leverage,” “unlock,” “foster,” and “at its core.”
- Do not sound promotional, overly polished, ceremonial, or artificially enthusiastic.
- Do not use abstract nouns when a direct verb works.
- Do not trade clarity for sophistication. When in doubt, choose the simpler wording.
- Before returning the rewrite, check every sentence and remove anything that sounds like jargon, corporate copy, or an AI-generated answer.

## ADHD-Friendly Formatting

Make scanning easy:

- Put the most important thing first.
- Bold only the few words that matter.
- Use whitespace generously.
- Use action-oriented labels: `Decision`, `Risk`, `Next`, `Blocked`, `Ask`.
- Avoid dense nested bullets unless the structure is necessary.

## Compression Levels

If the user does not specify a level, use **Medium**.

- **Light:** Keep most detail, improve readability.
- **Medium:** Cut roughly 50–70%; keep key context and actions.
- **Hard:** Cut to essentials only; 3–8 bullets max.
- **Extreme:** One sentence plus next action.

## Handling Ambiguity

If the input is missing, ask the user to paste the text.

If the user says only “sss this” after a previous message, summarize the most recent long assistant/user content in the conversation.

If the text includes sensitive nuance, keep a `Caveat` bullet rather than deleting it.

## Optional Formats

Use these when helpful:

### Executive skim

```markdown
**Bottom line:** …

- **Decision:** …
- **Why:** …
- **Risk:** …
- **Next:** …
```

### Message rewrite

```markdown
Hi …,

[short rewritten message]

Thanks,
```

### Diff of meaning

Use only when the user asks what changed:

```markdown
Kept:
- …

Removed:
- Repetition
- Background that did not affect the decision

Changed:
- Made the ask explicit
```
