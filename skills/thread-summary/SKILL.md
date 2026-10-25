---
name: thread-summary
description: Summarize the current conversation thread in concise, plain language. Use when the user asks for /thread-summary, a thread recap, a summary of this conversation, or a quick catch-up on decisions and next steps. Unlike sss, cover the whole available thread, not just the latest message.
---

# Thread Summary

Summarize the current conversation so the user can quickly understand where it stands.

## Source and scope

- Use the whole available thread, not just the most recent response.
- Summarize the conversation; do not execute tasks discussed in it.
- Let later corrections and explicit decisions replace earlier proposals.
- Distinguish completed work from plans, attempts, and unverified claims.
- If earlier context is unavailable, say so briefly. Do not invent missing history.
- Do not ask the user to paste text when the conversation is already available.

## SSS guidance

Read [the SSS skill](../sss/SKILL.md) and apply its plain-language and compression rules.
Use this skill's whole-thread scope and output format instead of SSS's defaults.
If SSS is unavailable, use short sentences and bullets. Remove filler, repetition,
jargon, and background that does not affect a decision or next action.

## Default output

Aim for 150 words or fewer unless the user requests more detail. Use only sections
that have useful content:

```markdown
**Summary:** One or two sentences on the goal and current state.

**Decisions**
- Settled choice or important constraint.

**Status**
- Completed work or verified result.
- Pending work or blocker, clearly labeled.

**Open questions**
- Unresolved choice that affects what happens next.

**Next steps**
- Concrete action, with its owner only if established.
```

For a simple thread, use 3–5 bullets instead of headings.

## Accuracy check

- Keep only details needed to understand the outcome or continue the work.
- Preserve exact file paths, commands, names, numbers, and deadlines when needed.
- Keep caveats that change a decision. Do not turn an attempt into a success.
- Do not treat silence as approval or an assistant suggestion as a user decision.
- Omit credentials and sensitive values, even if they appeared in the thread.
- Output only the summary. No preface, follow-up offer, or new recommendations.
