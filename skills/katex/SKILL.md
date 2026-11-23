---
name: "katex"
description: "Convert a screenshot or photo of a math equation into KaTeX source in a code block. Use whenever the user shares an image of math and wants KaTeX, LaTeX, or the equation as code."
disable-model-invocation: true
---

# Equation to KaTeX

Turn an image of math (screenshot, textbook photo, handwriting, slide, PDF crop) into KaTeX source the user can paste straight into a KaTeX field.

## Output format

Reply with **only** one fenced code block (language tag `latex`) holding the KaTeX source:

- No `$`, `$$`, `\(` or `\[` delimiters. The user pastes the raw expression into tools that add their own.
- No preamble, explanation or rendered preview. The user wants something to copy, and extra text gets in the way.
- One exception: if part of the image is truly unreadable (blurred, cropped, ambiguous handwriting), give your best guess in the code and add **one short line** under the block naming the guess (e.g. `Unclear: read the exponent as n+1`). Leave it out when everything is legible.

### Several equations or multi-line work

Put every line into a single `aligned` environment, with `&` placed before the relation symbol so the `=` (or `\le`, `\Rightarrow`, …) signs line up and `\\` between lines:

```latex
\begin{aligned}
(x+1)^2 &= x^2 + 2x + 1 \\
        &= x(x+2) + 1
\end{aligned}
```

Use `aligned` rather than `align`/`align*`, because those only work in KaTeX display mode and can fail when pasted without delimiters. A single equation needs no environment.

## Process

1. **Read the whole image first.** Find the overall structure (fractions, roots, sums, integrals, matrices, cases) before transcribing symbols, so the nesting comes out right.
2. **Transcribe faithfully.** Reproduce what is shown, not a simplified or "corrected" version. Keep the original variable names, order of terms and notation (e.g. `\frac{dy}{dx}` vs `y'`). If the image has an obvious mistake, transcribe it as shown.
3. **Check KaTeX compatibility** (below), then output.

## KaTeX conventions

KaTeX supports a subset of LaTeX. Stick to commands it renders:

- **Function names**: `\sin`, `\cos`, `\log`, `\ln`, `\exp`, `\lim`, `\max`, `\det`, … For names without a built-in command, use `\operatorname{name}` (KaTeX has no `\DeclareMathOperator`).
- **Groups**: use braces for multi-character scripts: `x^{2n}`, `a_{ij}`, `e^{-x^2}`.
- **Fractions**: `\frac{a}{b}`; `\dfrac` only if the image clearly shows a full-size fraction inline.
- **Brackets**: use `\left( … \right)` around tall content such as fractions, sums or matrices; plain `( )` otherwise.
- **Integrals and differentials**: thin space before the differential: `\int_0^1 f(x)\,dx`. Use `\mathrm{d}x` only if the image shows an upright d.
- **Sums, products, limits**: `\sum_{i=1}^{n}`, `\prod_{k=1}^{\infty}`, `\lim_{x \to 0}`.
- **Matrices**: `pmatrix` ( ), `bmatrix` [ ], `vmatrix` | |, matching the brackets in the image.
- **Piecewise**: `\begin{cases} … & \text{if } … \\ … \end{cases}`.
- **Text inside math**: `\text{…}` with the spacing written explicitly (`\text{ for all }`).
- **Sets and fonts**: `\mathbb{R}`, `\mathcal{L}`, `\mathbf{v}` (bold vector), `\vec{v}` (arrow vector), `\hat{x}`, `\bar{x}`; match how the image marks it.
- **Dots**: `\ldots` on the baseline (`1, 2, \ldots, n`), `\cdots` at the center (`a_1 + \cdots + a_n`), `\vdots`, `\ddots` in matrices.
- **Operators**: `\cdot` for a centered dot, `\times` for ×, `\pm`, `\le`, `\ge`, `\ne`, `\approx`, `\equiv`, `\in`, `\subseteq`, `\to`, `\Rightarrow`, `\iff`, `\infty`, `\partial`, `\nabla`.
- **Primes**: `f'(x)`, `f''(x)`.
- **Avoid** packages and macros KaTeX lacks: `siunitx` (`\SI`), `\newcommand` unless needed, `align`/`eqnarray`, `\begin{equation}`, `\label`, `\tag` (unless the image shows an equation number and the user needs it).

## Final check

Before replying, confirm that every `{` has a matching `}`, every `\left` has a `\right`, every environment is closed, and reading the source back gives the same equation as the image.