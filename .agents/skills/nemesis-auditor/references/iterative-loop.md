# Nemesis Iterative Loop

## Contents
- Recon
- Shared mapping
- Full baseline passes
- Targeted loop mechanics
- Multi-transaction tracing

## Recon

Start with five questions:

1. What is the worst thing an attacker can achieve?
2. What code is novel rather than inherited from battle-tested libraries?
3. Where does value actually sit, and what paths move it out?
4. What interaction path is the most complex?
5. Which value-bearing states probably depend on other storage staying in sync?

Turn the answers into a priority list. Functions or modules that appear in multiple answers deserve the deepest scrutiny.

## Shared Mapping

Build three connected artifacts before the first targeted re-pass:

1. A function-state matrix:
   - function
   - state reads
   - state writes
   - guards
   - internal calls
   - external calls
2. A coupled-state dependency map:
   - state A
   - state B
   - invariant that must hold
   - functions that mutate either side
3. A Nemesis cross-reference:
   - which functions write one side only
   - which functions update both sides
   - which functions are already suspected for ordering or logic concerns

Treat any function that writes one side of a coupled pair without an obvious write to the counterpart as a primary audit target.

## Full Baseline Passes

Run the first two passes in full:

1. Pass 1 - Feynman
   - run the full Feynman workflow
   - collect verified and raw findings, suspects, assumptions, and ordering concerns
2. Pass 2 - State Inconsistency
   - run the full state workflow
   - use all Pass 1 output as enrichment
   - confirm or refute suspected gaps and discover additional coupled pairs

These passes establish the baseline. Do not skip sections during Pass 1 or Pass 2.

## Targeted Loop Mechanics

After Pass 2, alternate targeted passes only on new information:

### State to Feynman

For every new state gap:

- Ask why the function mutates state A without updating state B.
- Identify the assumption that made the omission look safe.
- Find the downstream operation that reads stale state.
- Build the smallest exploit sequence that abuses the stale state window.

### Feynman to State

For every new Feynman suspect:

- Check whether the touched state belongs to a coupled pair.
- Check whether the suspicious ordering creates a measurable gap.
- Check whether the assumption violation implies a new dependency that was not mapped earlier.

### Masking Code

For every clamp, `min`, early return, silent fallback, or defensive branch:

- Ask what invariant would have broken without the mask.
- Trace backward to the root mutation that created the inconsistency.
- Treat the mask as evidence, not as mitigation, unless verification proves otherwise.

## Convergence Rules

Continue alternating while the current pass introduces any new:

- verified or plausible findings
- coupled pairs
- mutation paths
- suspects
- masking patterns with a new root cause

Stop when a pass produces no meaningful delta, or when the total reaches 6 passes.

## Multi-Transaction Tracing

Build adversarial sequences for confirmed or high-confidence issues:

- deposit -> partial withdraw -> claim
- stake -> unstake half -> restake -> exit
- borrow -> partial repay -> borrow again
- provide liquidity -> swap activity -> withdraw
- delegate -> transfer -> vote

For each sequence, verify whether repeated operations with different amounts create path-dependent accounting or stale-state drift.
