---
name: "markdown"
description: "Convert a screenshot or image of text (docs, tables, code, terminal, slides, math) into clean, copy-pasteable Markdown in a code block. Use whenever the user shares an image and wants Markdown or transcribed text."
disable-model-invocation: true
---

# Screenshot to Markdown

Turn the text content of a screenshot into faithful Markdown the user can paste straight into a `.md` file, README, Obsidian, GitHub, etc.

Use this whenever the user shares a screenshot, photo, or image of a document, article, notes, table, spreadsheet, code, terminal output, slide, or math and wants it as Markdown, text, or "transcribed" — including phrasings like "convert this to markdown", "md version of this", "transcribe this screenshot", "OCR this", "turn this image into text", or just an image with "markdown?".

## Output format

Reply with exactly one fenced code block tagged `markdown` containing the conversion, and nothing else unless there's a genuine problem worth flagging (see "When to add a note").

The user wants to copy the raw syntax, so it must be inside a code block — rendered Markdown in chat loses the `#`, `|` and `**` characters they need.

Because the outer block uses backticks, if the content itself contains a fenced code block, wrap the outer block in **four** backticks (````markdown … ````) so the inner ``` fences don't close it early.

## What to include: text only

Transcribe the document's text content. Leave out everything that isn't text:

- **Skip** images, photos, charts, diagrams, icons, logos, emoji-like decorative glyphs — no `![alt]()` placeholders, no descriptions of them.
- **Skip** UI chrome: browser tabs, address bars, app toolbars, nav menus, sidebars, buttons ("Share", "Edit", "Subscribe"), scrollbars, window controls, cookie banners, timestamps/status bars of the OS.
- **Keep** text that's part of the content even if it sits in a box: callouts, captions, table cells, slide titles, code, labels on a form if the form is the content.

A good test: if the user had the original source file, would this text be in it? Keep it. If it only exists because of the app/website displaying it, drop it.

## Fidelity

- Transcribe words exactly — spelling, capitalization, numbers, punctuation. Don't fix typos, paraphrase, summarize, or "improve" wording; the user wants what's in the image.
- Don't invent content. If text is cut off at the screenshot edge, transcribe what's visible and stop (see notes below).
- Preserve order: top-to-bottom, and left-to-right for multi-column layouts (finish column one, then column two).

## Mapping visuals to Markdown

Infer structure from visual cues — size, weight, indentation, bullets, alignment.

| Visual cue | Markdown |
|---|---|
| Largest title text | `#` |
| Section / subsection headings | `##`, `###` … (keep levels relative; don't skip levels without reason) |
| Bold / italic / strikethrough | `**bold**`, `*italic*`, `~~strike~~` |
| Inline monospace text | `` `code` `` |
| Bullets (•, –, ◦) | `-` with 2-space indent per nesting level |
| Numbered lists | `1.` `2.` … keep original numbering |
| Checkboxes | `- [ ]` / `- [x]` |
| Quote / indented callout | `> ` |
| Horizontal divider | `---` |
| Visible link text (underlined/blue) | `[text](url)` if URL visible, otherwise just the text |

### Tables / spreadsheets

- Use a GitHub-style pipe table with a header row and `---` separator row.
- Keep every visible row and column, in order. Leave empty cells empty (`| |`) rather than dropping them, so columns stay aligned.
- If a spreadsheet shows row numbers / column letters (A, B, C / 1, 2, 3) as UI, drop them — they're chrome, not data.
- Escape literal pipes inside cells as `\|`.
- Match column alignment with `:---`, `:---:`, `---:` only when it's clearly visible (e.g., right-aligned numbers).

### Code and terminal

- Use a fenced block with the language tag when identifiable (`python`, `bash`, `js`, `json`, …). For terminal sessions use `bash` or `console` and keep the prompt (`$`) and output as shown.
- Preserve indentation exactly — it matters in Python/YAML.
- Drop editor chrome: line numbers in the gutter, file tabs, minimap.

### Math

- Use LaTeX: `$...$` inline, `$$...$$` on their own lines for display equations.
- Transcribe the math as shown (fractions as `\frac{}{}`, subscripts `_`, superscripts `^`, Greek letters `\alpha`, sums `\sum_{i=1}^{n}`, etc.).

### Slides

- Slide title → `##` (or `#` if it's a single slide).
- Bullet hierarchy → nested lists.
- Drop slide numbers, footers with presenter/company boilerplate, and logos.
- Multiple slides in one image: separate with `---`.

## When to add a note

Normally output only the code block. Add one short line *after* it only if:
- Some text is unreadable — mark it inline as `[illegible]` and mention it.
- Content is clearly cut off at the edge of the screenshot.
- The image contains no transcribable text at all (then say so instead of returning an empty block).

## Example

Screenshot: a Notion page with sidebar, a "Share" button, a cover photo, a title "Sprint Notes", a bold "Goals" heading, two bullets ("Ship login v2", "Fix *flaky* tests") and a small table (Owner | Task / Ana | API).

Output:

```markdown
# Sprint Notes

## Goals

- Ship login v2
- Fix *flaky* tests

| Owner | Task |
|---|---|
| Ana | API |
```

(Sidebar, Share button and cover photo are dropped.)