---
name: nemesis-auditor
description: Iterative security audit orchestrator that combines the sibling skills feynman-auditor and state-inconsistency-auditor into alternating passes until convergence, then produces a verified combined report. Use when Codex needs maximum-depth business-logic plus coupled-state analysis, a deep combined audit, a Nemesis audit, or a cross-feed review of a complex protocol or codebase.
---

# Nemesis Auditor

Treat this skill as the orchestrator. Use the full methodologies of `$feynman-auditor` and `$state-inconsistency-auditor`, then force them to interrogate each other's findings until no new bugs surface.

## Operating Rules

1. Start with attacker recon and an initial coupling hypothesis before reading deep implementation details.
2. Run the full Feynman workflow first. Produce findings, suspects, exposed assumptions, and a function-state matrix.
3. Run the full state inconsistency workflow second. Use the Feynman output as additional audit targets and expand the coupled-state map.
4. Re-run alternating targeted passes only on new findings from the previous pass. Do not re-audit areas already cleared.
5. Stop when a pass produces no meaningful delta or when the total reaches 6 passes.
6. Verify every critical, high, and medium finding before presenting it as a result.
7. Present only the verified combined report to the user.

## Execution Flow

1. Build a recon summary: attack goals, novel code, value stores, complex paths, and suspected coupled state.
2. Build the shared map:
   - Function-state matrix from the Feynman side
   - Coupled-state dependency map from the state side
   - Cross-reference showing which functions mutate only one side of a coupled pair
3. Run Pass 1 with the Feynman methodology.
4. Run Pass 2 with the state inconsistency methodology, enriched by Pass 1 output.
5. Alternate targeted passes:
   - State gaps become Feynman re-interrogation targets
   - Feynman suspects become state dependency expansion targets
   - Masking code gets joint root-cause analysis
6. Build minimal adversarial multi-transaction sequences for confirmed issues.
7. Verify and consolidate all findings into one final report.

## Pass Handoff Rules

- Feed every Feynman suspect, ordering concern, hidden assumption, and touched state variable into the state pass.
- Feed every state gap, missing synchronization path, masking pattern, and newly discovered coupled pair into the next Feynman pass.
- Track what is new in each pass. The next pass should consume only that delta.
- Mark each confirmed finding with its discovery path:
  - `Feynman-only`
  - `State-only`
  - `Cross-feed Pn->Pm`

## Outputs

- Keep intermediate files under `.audit/findings/`.
- Use pass-specific files such as `feynman-pass1.md`, `state-pass2.md`, `feynman-pass3.md`, and `state-pass4.md` when useful.
- Save raw merged work to `.audit/findings/nemesis-raw.md`.
- Save the final verified report to `.audit/findings/nemesis-verified.md`.

## Required References

- Open `references/iterative-loop.md` before running the first pass.
- Open `references/reporting-and-checklists.md` before verification and final write-up.
- Open the sibling references for `$feynman-auditor` and `$state-inconsistency-auditor` whenever you need their full question catalogs, workflow details, or reporting templates.

## Final Delivery Standard

- Keep raw findings separate from verified findings.
- Include the unified Nemesis map, verification summary, verified findings, cross-feed discoveries, false positives eliminated, downgraded findings, and a concise summary.
- Do not mention Claude-specific commands or legacy Claude paths.
