# Vibe_Maths

Machine-checked proofs of mathematical statements in [Lean 4](https://lean-lang.org/) with [Mathlib](https://github.com/leanprover-community/mathlib4).

Targets are theorem statements from [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures), taken via the [Left to Solve](https://lefttosolve.com) project. Proofs are submitted as pull requests to [open-math-agents](https://github.com/GuillaumeBAUD-coder/open-math-agents), whose CI checker compiles them. A proof counts only if the Lean kernel accepts it with no `sorry` and no axioms beyond `propext`, `Classical.choice` and `Quot.sound`.

## Results

| Problem | Kind | File | Status |
|---|---|---|---|
| _none yet_ | | | |

- **submitted**: compiles and passes the axiom check locally; pull request open upstream.
- **accepted**: merged upstream after the CI checker passed.
- **rejected**: refused by the upstream checker; the reason is linked.

Results of kind "known" are published theorems formalized in Lean. They are not new mathematics.

## Statements

Formal statements (theorem with `sorry`, no proof) contributed upstream for problems that had none.

| Problem | Statement | File | Pull request | Status |
|---|---|---|---|---|
| [oeis-a083020](https://lefttosolve.com/p/oeis-a083020) | `∀ n : ℕ, Squarefree (3 ^ (3 ^ n) + 2)` (OEIS conjecture, false) | [statements/oeis-a083020.lean](statements/oeis-a083020.lean) | [open-math-agents#17276](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/17276) | submitted, upstream check queued |

Notes on oeis-a083020:

- **The conjecture is false.** 29² divides 3^(3^n) + 2 for n = 73 and n = 157, which you can check by computing 3^(3^n) mod 841. The statement file encodes the conjecture as OEIS states it. It does not claim the conjecture is true.
- **There is a second PR for the same problem.** [#16672](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/16672) by another contributor was opened upstream first, at 01:09:31 UTC on 2026-11-28. This statement was committed and accepted by this repo's CI earlier, in commit [`830443d`](https://github.com/prathameshnium/Vibe_Maths/commit/830443d833fd3e68e9ce75d2c092a2400f78d79e) at 00:52:30 UTC, while the repo was still private. Both statements are mathematically identical. Upstream will merge at most one, and if it merges #16672, #17276 will be closed.

## Layout

```
proofs/<problem-id>.lean       one self-contained file per problem, identical to the upstream submission
statements/<problem-id>.lean   formal statements submitted upstream, identical to the upstream file
```

Each file starts with the import line of the upstream problem file and proves `theorem OMA.solution : type_of% @<declaration>` (or `OMA.disproof : ¬ ...`), which pins the statement exactly to the upstream one.

## Verify a proof

```sh
git clone https://github.com/GuillaumeBAUD-coder/open-math-agents && cd open-math-agents
tools/oma.sh setup                  # formal-conjectures at the pinned commit + Mathlib cache
cp ../Vibe_Maths/proofs/<id>.lean proofs/
tools/oma.sh check <id>             # compiles and prints the axioms used
```

## Credit and license

Maintained by [@prathameshnium](https://github.com/prathameshnium). Correctness rests on the Lean kernel, not on informal review. Released under the MIT license, see [LICENSE](LICENSE).

| Tooling | |
|---|---|
| Model | Claude Opus 5.5 (`claude-opus-5-5`, Anthropic) |
| Agent harness | Claude Code (Anthropic), run inside T3 Code |
| Proof checker | Lean 4 kernel + Mathlib, at the commit pinned by open-math-agents |

Each upstream pull request records the same tooling in its `Agent:` and `Model:` lines.
