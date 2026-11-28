<div align="center">

# Vibe_Maths

**Machine-checked mathematics in Lean 4, contributed to open problems on [Left to Solve](https://lefttosolve.com).**

[![proofs](https://github.com/prathameshnium/Vibe_Maths/actions/workflows/lean-check.yml/badge.svg)](https://github.com/prathameshnium/Vibe_Maths/actions/workflows/lean-check.yml)
[![reductions](https://github.com/prathameshnium/Vibe_Maths/actions/workflows/reduction-check.yml/badge.svg)](https://github.com/prathameshnium/Vibe_Maths/actions/workflows/reduction-check.yml)
[![statements](https://github.com/prathameshnium/Vibe_Maths/actions/workflows/statement-check.yml/badge.svg)](https://github.com/prathameshnium/Vibe_Maths/actions/workflows/statement-check.yml)

[![Lean](https://img.shields.io/badge/Lean-v4.33.1-0f4c81)](https://lean-lang.org/)
[![Mathlib](https://img.shields.io/badge/Mathlib-pinned%20by%20open--math--agents-5c2d91)](https://github.com/leanprover-community/mathlib4)
[![Left to Solve](https://img.shields.io/badge/Left%20to%20Solve-%40prathameshnium-2e7d32)](https://lefttosolve.com)
[![License: MIT](https://img.shields.io/badge/license-MIT-lightgrey)](LICENSE)

</div>

Targets are theorem statements from [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures), handed out by Left to Solve. Every file here is submitted as a pull request to [open-math-agents](https://github.com/GuillaumeBAUD-coder/open-math-agents), whose CI compiles it. **A result counts only if the Lean kernel accepts it with no `sorry` and no axioms beyond `propext`, `Classical.choice` and `Quot.sound`.** The badges above run that same upstream checker on every file in this repo.

## At a glance

| | Count | What it means |
|---|:---:|---|
| 🧩 Reductions | **3** | open conjectures split into a finite range plus an open rest, submitted upstream |
| 📝 Statements | **1** | a formal statement written for a problem that had none, submitted upstream |
| ✅ Proofs | **0** | none merged yet |

## Reductions

A reduction splits an open problem into smaller statements `H1`, `H2` and proves, in Lean, that together they imply the original. Once merged upstream, each `H` becomes its own problem. These three split an open conjecture at a bound: `H1` is the finite range, which a kernel-checked search can settle, and `H2` is everything above it, which stays open. **None of them proves the conjecture.**

| Problem | Conjecture | Split | File | Pull request | Status |
|---|---|---|---|---|---|
| [A232194 · 4](https://lefttosolve.com/p/OeisA232194.conjecture_4) | `n * x ^ 2 + y` is prime for some `x + y = n` | `H1`: `1 < n ≤ 1000`, `n ≠ 8` · `H2`: `n > 1000` | [`.R1.lean`](reductions/OeisA232194.conjecture_4.R1.lean) | [#20573](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/20573) | 🟡 submitted |
| [A218656 · 2](https://lefttosolve.com/p/OeisA218656.conjecture_2) | `x ^ 2 + (2n + 1 - x) ^ 2` is prime for some `1 ≤ x ≤ n` | `H1`: `n ≤ 1000` · `H2`: `n > 1000` | [`.R1.lean`](reductions/OeisA218656.conjecture_2.R1.lean) | [#20867](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/20867) | 🟡 submitted |
| [Dubner](https://lefttosolve.com/p/DubnerConjecture.dubner_conjecture) | every even `n > 4208` is a sum of two twin primes | `H1`: `n ≤ 10000` · `H2`: `n > 10000` | [`.R1.lean`](reductions/DubnerConjecture.dubner_conjecture.R1.lean) | [#21163](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/21163) | 🟡 submitted |

All three passed the upstream checker locally: `kernel accepted; axioms within propext, Classical.choice, Quot.sound`.

## Statements

Formal statements (a theorem with `sorry`, no proof) contributed upstream for problems that had none.

| Problem | Statement | File | Pull request | Status |
|---|---|---|---|---|
| [oeis-a083020](https://lefttosolve.com/p/oeis-a083020) | `∀ n : ℕ, Squarefree (3 ^ (3 ^ n) + 2)` | [`oeis-a083020.lean`](statements/oeis-a083020.lean) | [#17276](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/17276) | 🟡 submitted, upstream CI passed |

> **Note on oeis-a083020.** The OEIS conjecture is **false**: 29² divides 3^(3^n) + 2 at n = 73 and n = 157, as computing 3^(3^n) mod 841 shows. The file states the conjecture as OEIS gives it and does not claim it is true. A second PR for the same problem, [#16672](https://github.com/GuillaumeBAUD-coder/open-math-agents/pull/16672), was opened upstream first (01:09:31 UTC, 2026-11-28); this statement was committed and accepted by this repo's CI earlier, in [`830443d`](https://github.com/prathameshnium/Vibe_Maths/commit/830443d833fd3e68e9ce75d2c092a2400f78d79e) (00:52:30 UTC), while the repo was private. The two statements are identical, and upstream will merge at most one.

## Proofs

| Problem | Kind | File | Status |
|---|---|---|---|
| _none yet_ | | | |

Results of kind "known" are published theorems formalized in Lean. They are not new mathematics.

**Status key:** 🟡 **submitted**, passes the checker locally and the pull request is open upstream · ✅ **accepted**, merged upstream after its CI passed · ❌ **rejected**, refused by the upstream checker (reason linked).

## Layout

```
proofs/<problem-id>.lean            a proof (OMA.solution) or disproof (OMA.disproof), identical to the upstream file
reductions/<problem-id>.R<n>.lean   a reduction: H1 ... Hk and main : H1 → … → target
statements/<problem-id>.lean        a formal statement for a problem that had none
```

Each file starts with the import line of the upstream problem and proves its target through `type_of% @<declaration>`, which pins the statement exactly to the upstream one.

## Verify it yourself

```sh
git clone https://github.com/GuillaumeBAUD-coder/open-math-agents && cd open-math-agents
tools/oma.sh setup                              # formal-conjectures at the pinned commit + Mathlib cache
cp ../Vibe_Maths/proofs/<id>.lean proofs/       # or reductions/, statements/
tools/oma.sh check <id>                         # compiles and prints the axioms used
```

## Credit and license

Maintained by [@prathameshnium](https://github.com/prathameshnium). Correctness rests on the Lean kernel, not on informal review. Released under the [MIT license](LICENSE).

| Tooling | |
|---|---|
| Model | Claude Opus 5.5 (`claude-opus-5-5`, Anthropic) |
| Agent harness | Claude Code (Anthropic), run inside T3 Code |
| Proof checker | Lean 4 kernel + Mathlib, at the commit pinned by open-math-agents |

Each upstream pull request records the same tooling in its `Agent:` and `Model:` lines.
