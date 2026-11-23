---
name: better-phrasing
description: "Instantly rewrite a word, phrase, sentence, or short passage into multiple polished alternatives. Trigger this skill whenever the user asks for a better way to say something, wants to rephrase text, needs synonyms or tone adjustments, or passes in a phrase/sentence that feels awkward, too blunt, too casual, or too formal. Trigger phrases include: \"better way to say\", \"rephrase\", \"how do I say\", \"nicer way to put\", \"more professional version\", \"softer way to say\", \"reword this\", or any time the user just pastes a phrase expecting improvement. Even if the request is short or terse (e.g. just \"better way to say 'I don't care'\"), apply this skill immediately without asking for clarification.\n"
disable-model-invocation: true
---

# Better Phrasing Skill

## Purpose
Turn an awkward, blunt, or unclear phrase into several polished alternatives,
each labelled by tone so the user can pick the one that fits their context.

## Input
The user's input may be:
- A single word or short phrase: `"per my last email"`
- A full sentence: `"I don't have time for this"`
- A short paragraph
- A contextual hint alongside the phrase: `"professional email: we need this ASAP"`

If context is given (audience, medium, tone goal), use it. If not, cover a
range of tones so at least one alternative will fit.

## Output Format

Present alternatives as a compact numbered list. Each entry:
1. **Label** (1–3 words describing tone/register: e.g. *Professional*, *Warm*, *Direct*, *Diplomatic*)
2. The rewritten phrase in plain text
3. One-line note only when genuinely useful (optional — don't pad)

**Keep it scannable.** The user wants to grab-and-go, not read an essay.

### Example output shape
```
Better ways to say "I don't care":

1. **Neutral** — I'll leave that decision to you.
2. **Professional** — I'm happy with either option.
3. **Warm** — Whatever works best for you works for me!
4. **Direct** — I have no strong preference here.
```

## How many alternatives?
- Default: **4–5** alternatives covering a spread of tones
- If the user specifies a tone (e.g. "formal only"), give **2–3** tight variants
- If the phrase is very context-specific, prioritise fit over variety

## Tone labels to consider (use the most relevant)
Professional · Formal · Casual · Warm · Empathetic · Diplomatic · Assertive ·
Concise · Friendly · Firm · Polite · Neutral · Encouraging · Direct

## Edge cases
- **Slang / offensive phrases**: rephrase without moralising; just deliver clean alternatives
- **Non-English input**: respond in the same language
- **Ambiguous intent**: pick the most charitable interpretation and note it briefly at the top
- **Long paragraphs (>3 sentences)**: rewrite the whole thing but flag that it's a full rewrite

## What NOT to do
- Don't ask clarifying questions for simple one-liner phrases — just deliver alternatives
- Don't explain what was wrong with the original phrase unless the user asks
- Don't pad with intros like "Certainly! Here are some alternatives…"
- Don't include more than one optional note per alternative
