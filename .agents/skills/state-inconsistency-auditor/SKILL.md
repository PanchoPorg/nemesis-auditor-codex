---
name: state-inconsistency-auditor
description: Structural invariant audit skill that maps coupled state, mutation paths, ordering gaps, masking logic, and parallel code paths to find state desynchronization bugs. Use when Codex needs a state inconsistency audit, coupled-state review, stale-state analysis, or structural invariant checking for contracts, services, or other stateful systems.
---

# State Inconsistency Auditor

Use this skill to find places where the code updates one piece of state without keeping the rest of its dependent accounting synchronized.

## Core Workflow

1. Detect the language and adapt terminology.
2. Map every coupled-state relationship before hunting for bugs.
3. Build the mutation matrix for every side of every coupled pair.
4. Cross-check every mutation path for missing synchronization.
5. Check ordering within functions, parallel code paths, and multi-step user journeys.
6. Treat masking logic as evidence of a likely broken invariant until verification disproves it.
7. Verify every critical, high, and medium finding before presenting it.

## Operating Standard

- Do not start from individual functions alone. Start from the dependency map.
- Trace direct writes, indirect writes, hooks, callbacks, deletes, resets, and batch paths.
- Compare normal, emergency, admin, wrapper, partial, full, and batch paths.
- Confirm that a coupled relationship is real by finding code that reads both values together or depends on them staying aligned.
- Present only verified results to the user.

## Outputs

- Save raw work to `.audit/findings/state-inconsistency-raw.md`.
- Save the verified report to `.audit/findings/state-inconsistency-verified.md`.

## Required References

- Open `references/coupled-state-workflow.md` before the deep audit.
- Open `references/reporting-and-verification.md` before assigning severity or writing the final report.

## Final Delivery Standard

- Include the coupled-state dependency map, mutation matrix, parallel path comparison, verification summary, verified findings, false positives eliminated, and summary.
- Keep the exact coupled pair, broken invariant, breaking operation, and downstream consequence for each confirmed finding.
