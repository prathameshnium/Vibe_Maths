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

## Reductions

A reduction splits an open problem into smaller statements `H1`, `H2` and proves, in Lean, that they imply the original. Once merged upstream, each `H` becomes its own problem. These three split an open conjecture at a bound `B`: `H1` is the finite range up to `B`, which a kernel-checked search can settle, and `H2` is everything above `B`, which stays open. None of them proves the conjecture.

| Problem | Split | File | Pull request | Status |
|---|---|---|---|---|
| [OeisA232194.conjecture_4](https://lefttosolve.com/p/OeisA232194.conjecture_4) | `n * x ^ 2 + y` prime for some `x + y = n`: `H1` for `1 < n ≤ 1000` (`n ≠ 8`), `H2` for `n > 1000` | [reductions/OeisA232194.conjecture_4.R1.lean](reductions/OeisA232194.conjecture_4.R1.lean) | [open-math-agents#20573](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/20573) | submitted |
| [OeisA218656.conjecture_2](https://lefttosolve.com/p/OeisA218656.conjecture_2) | `x ^ 2 + (2n + 1 - x) ^ 2` prime for some `1 ≤ x ≤ n`: `H1` for `n ≤ 1000`, `H2` for `n > 1000` | [reductions/OeisA218656.conjecture_2.R1.lean](reductions/OeisA218656.conjecture_2.R1.lean) | [open-math-agents#20867](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/20867) | submitted |
| [DubnerConjecture.dubner_conjecture](https://lefttosolve.com/p/DubnerConjecture.dubner_conjecture) | every even `n > 4208` is a sum of two twin primes: `H1` for `n ≤ 10000`, `H2` for `n > 10000` | [reductions/DubnerConjecture.dubner_conjecture.R1.lean](reductions/DubnerConjecture.dubner_conjecture.R1.lean) | [open-math-agents#21163](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/21163) | submitted |

Each file passed the local upstream checker (`kernel accepted; axioms within propext, Classical.choice, Quot.sound`). The finite-range proofs of the three `H1` steps can only be submitted after the reductions merge.

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
reductions/<problem-id>.R<n>.lean  reductions submitted upstream, identical to the upstream file
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
