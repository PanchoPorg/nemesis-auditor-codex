# Feynman Reporting And Verification

## Verification Rule

Treat raw findings as hypotheses. Do not present them as final results.

Verify every critical, high, and medium finding using one of these methods:

1. Deep code trace
   - trace the exact call chain
   - inspect callers, callees, wrappers, and related guards
   - confirm no mitigation invalidates the finding
2. PoC test
   - write a minimal test in the project's native framework
   - execute the exact trigger sequence
   - confirm the claimed behavior with concrete numbers or output
3. Hybrid
   - trace first, then confirm with a PoC

## Common False Positives

- authorization exists in a caller or router
- a called function validates the supposedly unchecked input
- downstream cleanup removes the supposed rounding issue
- loop bounds are tighter than they looked initially
- language safety invalidates the exploit theory
- severity is inflated relative to actual impact

## Severity

- Critical: direct value loss, permanent denial of service, or insolvency
- High: broken core invariant, privilege escalation, or conditional value loss
- Medium: incorrect accounting, value leakage, or griefing with cost
- Low: non-material inconsistency or informational issue

## Raw Output

Write `.audit/findings/feynman-analysis-raw.md` with:

- scope notes
- function-state matrix
- guard consistency notes
- inverse-operation parity notes
- all raw findings with preliminary severity

## Final Output

Write `.audit/findings/feynman-verified.md` with:

1. Scope
2. Verification summary
3. Function-state matrix
4. Guard consistency analysis
5. Inverse-operation parity
6. Verified findings
7. False positives eliminated
8. Downgraded findings
9. Summary

Per verified finding include:

- ID
- severity
- module, function, and line references
- verification method
- the exact Feynman question that exposed it
- a first-principles explanation
- verification evidence
- minimal attack scenario
- impact
- minimal fix

## Anti-Hallucination Protocol

Never:

- invent code or line references
- assume a guard exists without reading it
- claim a scenario is reachable without tracing it
- use vague language like "could potentially" in place of evidence

Always:

- cite exact code when possible
- verify assumptions by reading related code
- check initialization and defaults
- present only verified findings as results
