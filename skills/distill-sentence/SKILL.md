---
name: distill-sentence
description: Distills the immediately preceding message into one sentence, or up to N sentences when invoked with a positive integer argument. Use when the user asks for /distill-sentence, wants only the essential point, or says an SSS summary is still too long.
---

# Distill Sentence

Reduce the immediately preceding substantive message to its essential meaning.

## Output Contract

- With no argument, return exactly **one sentence**.
- With a positive integer `N`, return up to **N sentences**.
- Output only the distilled text: no heading, label, preface, bullets, commentary, or follow-up offer.
- Treat a bare integer supplied with the skill invocation as the sentence count, not as source text.
- Distill the message immediately before the skill invocation, not the invocation itself or these instructions.

## Rules

- Preserve the main conclusion, request, decision, or next action.
- Keep a caveat only when removing it would make the result misleading.
- Remove examples, repetition, background, hedging, filler, and meta-commentary.
- Use plain, natural language; never use jargon, corporate language, or recognizable LLM phrasing.
- Prefer short sentences, but do not omit essential meaning merely to make them short.
- Do not use semicolons, bullet-like fragments, or a run-on sentence to disguise multiple sentences as one.
- Do not add facts, advice, interpretation, or enthusiasm absent from the source.
- When `N` is provided, use no more than `N` grammatical sentences; use fewer when they are enough.

If there is no preceding substantive message to distill, ask for one in a single sentence.
