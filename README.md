# N E M E S I S

### The Inescapable Auditor for Codex

Nemesis is an iterative, language-agnostic security-audit workflow for
[Codex](https://developers.openai.com/codex/skills/). It combines two
complementary skills in an alternating feedback loop:

| Pass | Skill | Focus |
| --- | --- | --- |
| 1 | **Feynman Auditor** | Business-logic bugs found through first-principles questioning |
| 2 | **State Inconsistency Auditor** | Coupled-state desynchronization and missing mutation paths |
| 3+ | **Alternating targeted passes** | New findings from each pass become targets for the next |

The loop stops when a pass produces no meaningful delta or after six passes.
Critical, high, and medium findings must be verified before they appear in the
final report.

## Requirements

- Codex desktop app, CLI, or IDE extension with skills support
- A codebase to audit

## Installation

### User-level installation

Clone the repository and run the installer:

```bash
git clone https://github.com/PanchoPorg/nemesis-auditor-codex.git
cd nemesis-auditor-codex
./install_codex_skills.sh
```

The installer creates symlinks for all three skills under
`$HOME/.agents/skills`. Keep the cloned repository at the same path while the
skills are installed. It refuses to overwrite an existing non-symlink path.

Codex normally detects skill changes automatically. If the skills do not
appear, restart Codex.

To use a different installation directory, set `CODEX_SKILLS_DIR` for the
installer:

```bash
CODEX_SKILLS_DIR=/path/to/skills ./install_codex_skills.sh
```

### Repository-scoped installation

Copy the three directories from `.agents/skills/` into the target repository's
`.agents/skills/` directory. Codex discovers repository skills from that path.

## Usage

Invoke the complete iterative audit explicitly:

```text
Use $nemesis-auditor to run a deep business-logic and state-inconsistency audit on this codebase.
```

Scope the request in natural language when needed:

```text
Use $nemesis-auditor to audit only the contracts in src/vaults.
```

The two component methodologies are also available independently:

```text
Use $feynman-auditor to run a first-principles business-logic audit.
Use $state-inconsistency-auditor to audit coupled state and mutation paths.
```

Each skill allows implicit invocation when the request matches its description.
In Codex CLI and the IDE extension, you can also type `$` to select a skill.

## How It Works

1. **Recon:** identify attack goals, value stores, complex paths, and suspected
   coupled state.
2. **Feynman pass:** build a function-state matrix and challenge purpose,
   ordering, guards, assumptions, boundaries, and multi-transaction behavior.
3. **State pass:** build the coupled-state dependency map and mutation matrix,
   then check every mutation and parallel path for missing synchronization.
4. **Cross-feed:** send only newly discovered gaps and assumptions into the next
   targeted pass.
5. **Verification:** reproduce or disprove material findings and consolidate the
   verified result.

## Output

Audit work is written under `.audit/findings/` in the audited repository:

```text
.audit/findings/
├── feynman-pass1.md
├── state-pass2.md
├── feynman-pass3.md
├── state-pass4.md
├── nemesis-raw.md
└── nemesis-verified.md
```

Intermediate hypotheses remain separate from the final verified report.

## Repository Structure

```text
.agents/skills/
├── nemesis-auditor/
│   ├── SKILL.md
│   ├── agents/openai.yaml
│   └── references/
├── feynman-auditor/
│   ├── SKILL.md
│   ├── agents/openai.yaml
│   └── references/
└── state-inconsistency-auditor/
    ├── SKILL.md
    ├── agents/openai.yaml
    └── references/
```

## Origin and License

This repository is a Codex adaptation of
[0xiehnnkta/nemesis-auditor](https://github.com/0xiehnnkta/nemesis-auditor),
which was originally created for Claude Code. The original MIT license and
copyright notice are preserved in [LICENSE](LICENSE).
