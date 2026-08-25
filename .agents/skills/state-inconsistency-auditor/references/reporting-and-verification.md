# State Inconsistency Reporting And Verification

## Verification Rule

Verify every critical, high, and medium finding before presenting it.

Use one of these methods:

1. Code trace
   - trace the exact breaking operation
   - inspect internal calls, hooks, modifiers, wrappers, and callbacks
   - confirm no hidden reconciliation exists
2. PoC test
   - execute the trigger sequence in the project's native test framework
   - assert the invariant is broken after the operation
   - assert a downstream operation produces the claimed bad result
3. Hybrid
   - trace first, then confirm with a PoC

## Common False Positives

- hidden reconciliation in an internal call chain
- lazy evaluation that reconciles on read
- immutable or one-time initialized data
- designed asymmetry where the states are not truly coupled

## Severity

- Critical: desync causes direct value loss or permanent lock
- High: desync breaks a core path or creates conditional value loss
- Medium: desync causes incorrect accounting, griefing, or degraded functionality
- Low: desync causes a non-material edge-case or cosmetic issue

## Raw Output

Write `.audit/findings/state-inconsistency-raw.md` with:

- coupled-state dependency map
- mutation matrix
- parallel path comparison
- raw findings with preliminary severity

## Final Output

Write `.audit/findings/state-inconsistency-verified.md` with:

1. Coupled-state dependency map
2. Mutation matrix
3. Parallel path comparison
4. Verification summary
5. Verified findings
6. False positives eliminated
7. Summary

Per verified finding include:

- ID
- severity
- coupled pair
- invariant
- breaking operation with file and line references
- trigger sequence
- consequence
- masking code if present
- verification evidence
- minimal fix

## Anti-Hallucination Protocol

Never:

- assume two states are coupled without proof in the code
- claim a missing update without tracing the full write path
- stop at a raw gap if hidden reconciliation might exist

Always:

- show the exact mutation path
- show the downstream read that depends on the pair
- verify whether the gap is real, lazy, or intentionally asymmetric
