# Coupled State Workflow

## Contents
- Abstract pattern
- Dependency mapping
- Mutation matrix
- Core cross-check
- Ordering and path analysis
- Red flags

## Abstract Pattern

Look for state that must move together:

- balance and checkpoint
- stake and reward debt
- collateral and debt shares
- total supply and the sum of individual balances
- principal and cumulative index
- cached computation and the inputs it depends on

The bug appears when one path updates state A but leaves state B stale.

## Dependency Mapping

For every storage value, ask:

- What other value must change when this one changes?
- What invariant ties them together?
- Which functions mutate either side?
- Which downstream operations read both?

Build a dependency map that names the pair, invariant, and mutation points.

## Mutation Matrix

For each state variable in the dependency map, list every mutating path:

- direct writes
- increments and decrements
- deletes and resets
- internal calls
- hooks and callbacks
- batch operations
- external triggers or asynchronous updates

Mark whether each path definitely updates the coupled state, definitely does not, or still needs tracing.

## Core Cross-Check

For every mutation path ask:

- if state A changes, does state B also change?
- if the operation is partial, is the update proportional?
- if the operation transfers or moves value, does the coupled accounting move too?
- if the operation deletes or resets, are all paired values cleared consistently?

Any path that updates only one side is a primary finding candidate.

## Ordering And Path Analysis

Within a function:

- after each step, are all coupled pairs still consistent?
- does one step use values invalidated by a previous step?
- can an external call observe inconsistent state?

Across functions:

- compare transfer vs burn
- compare withdraw vs liquidate
- compare normal vs emergency or admin paths
- compare single vs batch paths
- compare wrapper vs direct internal paths

Across user journeys:

- trace repeated operations with changing amounts
- look for stale state that compounds over time
- verify whether later operations read mixed-epoch data

## Red Flags

- one side of a pair changes without writes to the other side
- partial operations exist, but only full operations clear state correctly
- claim or collect happens before reduce or remove
- one mapping deletes while the paired mapping remains
- a clamp, `min`, or silent fallback appears around a supposedly impossible condition
- emergency or migration code bypasses the normal synchronization path
