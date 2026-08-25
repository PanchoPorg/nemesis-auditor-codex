# Feynman Question Framework

## Contents
- Language adaptation
- Recon
- Seven question categories
- Cross-function analysis

## Language Adaptation

Use native concepts instead of forcing Solidity terminology onto every codebase.

- unit of code: contract, module, crate, package, class
- entry point: external or public function, exported function, public method
- access control: modifier, visibility, signer check, middleware, role gate
- state: storage, resource, struct field, database record, member variable
- failure: revert, abort, error return, panic, exception

## Recon

Ask these questions before reading line by line:

1. What is the worst thing an attacker can do here?
2. What code is novel?
3. Where does value or authority sit?
4. What interaction path is most complex?

Turn the answers into a hit list and prioritize functions that sit at the intersection of value, novelty, and complexity.

## Seven Question Categories

### 1. Purpose

- Why does this line exist?
- What invariant does it protect?
- What breaks if the line disappears?
- What specific attack or edge case motivated the check?
- Is the current check sufficient for that goal?

### 2. Ordering

- What happens if this line moves earlier?
- What happens if this line moves later?
- What state is first written, and what state is last read?
- Can the function abort after partial side effects?
- Does caller ordering or concurrency change the outcome?

### 3. Consistency

- Why does one sibling function have a guard that another lacks?
- Do inverse operations validate with similar strictness?
- Do similar parameters receive different validation?
- Do similar state-changing paths emit different events or logs?
- Do similar math paths use different safety behavior?

### 4. Assumptions

- What does the function assume about the caller?
- What does it assume about external data?
- What does it assume about current state?
- What does it assume about time or sequencing?
- What does it assume about prices, rates, sizes, or bounds?

### 5. Boundaries

- What happens on the first call?
- What happens on the last call?
- What happens when the amount is zero, one, max, or just below a threshold?
- What happens on repeated calls?
- What happens when collections are empty, huge, or near limits?

### 6. Return Values And Errors

- Are return values ignored?
- Does the code assume failures cannot happen?
- Does a silent fallback hide a real problem?
- Does an error path leave state inconsistent?

### 7. External Reordering And Multi-Transaction Behavior

- What can an external callee observe at the exact call site?
- What if the external call happens before state is made safe?
- What if the same function is called twice with different values?
- Does accumulated state drift over time or across paths?

## Cross-Function Analysis

After individual interrogation:

1. Group functions by shared writes and compare guards.
2. Pair inverse operations and compare validation, state effects, and events.
3. Map valid state transitions and ask how they can be skipped or abused.
4. Trace value flow and check whether value appears, disappears, or gets stranded unexpectedly.
