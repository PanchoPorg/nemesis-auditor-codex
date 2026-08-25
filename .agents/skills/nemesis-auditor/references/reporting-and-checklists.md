# Nemesis Reporting And Checklists

## Contents
- Verification rules
- Severity
- Final report shape
- Combined red flags
- Anti-hallucination protocol

## Verification Rules

Verify every critical, high, and medium finding before presenting it.

Use one of three methods:

1. Deep code trace
   - trace the full call chain
   - inspect hooks, modifiers, wrappers, and downstream consumers
   - confirm the issue is reachable end to end
2. PoC test
   - use the project's native test framework
   - execute the exact trigger sequence
   - assert the inconsistent state and the downstream consequence
3. Hybrid
   - trace first, then confirm with a PoC

Common false positives:

- hidden reconciliation in hooks or modifiers
- lazy evaluation on read rather than write
- immutable state after initialization
- designed asymmetry that is documented and intentional
- language-level safety that invalidates the supposed exploit
- severity inflation where impact is much lower than claimed
- economically infeasible attack paths

## Severity

- Critical: direct value loss, permanent denial of service, or insolvency
- High: conditional value loss, privilege escalation, or broken core invariant
- Medium: value leakage, griefing with cost, incorrect accounting, or degraded core behavior
- Low: informational or cosmetic issue with no material exploit value

## Final Report Shape

Write `.audit/findings/nemesis-verified.md` with these sections:

1. Scope
2. Nemesis map
3. Verification summary
4. Verified findings
5. Feedback loop discoveries
6. False positives eliminated
7. Downgraded findings
8. Summary

Per finding include:

- ID
- severity
- source
- verification method
- coupled pair and invariant when relevant
- Feynman question that exposed it
- state gap or dependency evidence that confirmed it
- breaking operation with file and line references
- trigger sequence
- consequence
- masking code if present
- verification evidence
- minimal fix

## Combined Red Flags

From the Feynman side:

- a line whose purpose cannot be explained
- an ordering choice with no clear justification
- inconsistent guards across sibling functions
- a hidden trust assumption about caller, data, time, or state
- an external call before state is made safe
- behavior that changes materially across repeated calls

From the state side:

- a function mutates one side of a coupled pair but not the other
- similar code paths handle synchronization differently
- partial operations forget proportional state updates
- claim or collect happens before reduce or remove without reconciliation
- one mapping resets while its paired mapping does not
- emergency or admin paths bypass normal synchronization
- masking code appears around a supposedly impossible condition

From the loop itself:

- both auditors flag the same function for different reasons
- the state pass reveals a gap and the Feynman pass explains the root cause
- the Feynman pass reveals an assumption and the state pass proves the state is stale

## Anti-Hallucination Protocol

Never:

- invent code, state, or dependencies
- assume a coupled pair without finding code that reads both sides together
- report raw findings as verified results
- skip verification for critical, high, or medium severity

Always:

- cite exact file paths and lines when possible
- trace internal calls for hidden updates
- check for lazy reconciliation before claiming stale state
- keep the discovery path for each confirmed finding
