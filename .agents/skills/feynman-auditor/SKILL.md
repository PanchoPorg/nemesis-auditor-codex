---
name: feynman-auditor
description: Reasoning-first business-logic audit skill that questions purpose, ordering, guards, assumptions, boundaries, error handling, and multi-transaction behavior to find logic bugs beyond pattern matching. Use when Codex needs a Feynman audit, deep logic review, business-logic bug hunting, or first-principles analysis of contracts, modules, or critical code paths.
---

# Feynman Auditor

Use this skill to reason about why the code is written the way it is, what invariant each decision protects, and what breaks if the reasoning is wrong.

## Core Workflow

1. Detect the language and use its native terminology.
2. Start with attacker recon before deep reading.
3. Build a function-state matrix for the full scope.
4. Interrogate each in-scope function with the Feynman question categories.
5. Run cross-function analysis for guard consistency, inverse-operation parity, state transitions, and value flow.
6. Save raw findings separately from verified findings.
7. Verify every critical, high, and medium issue before presenting it.

## Operating Standard

- Question every meaningful line, but spend the deepest effort on state changes, validation, external calls, math, and ordering.
- Explain issues from first principles rather than naming bug classes and moving on.
- Trace callers, callees, and related functions whenever a line only makes sense in context.
- Treat repeated-call behavior and multi-transaction drift as first-class audit targets.
- Present only verified results to the user.

## Outputs

- Save raw hypotheses to `.audit/findings/feynman-analysis-raw.md`.
- Save the verified report to `.audit/findings/feynman-verified.md`.

## Required References

- Open `references/question-framework.md` before the deep dive.
- Open `references/reporting-and-verification.md` before writing findings or assigning severity.

## Final Delivery Standard

- Include scope, verification summary, function-state matrix, guard consistency analysis, inverse-operation parity, verified findings, false positives eliminated, downgraded findings, and summary.
- Keep the exact question that exposed each confirmed finding.
