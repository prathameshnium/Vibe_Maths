import Mathlib

/-!
# A083020: Irregular triangle read by row of the prime factors of 3^(3^n) + 2.

Source: https://oeis.org/A083020
Credit: @prathameshnium (agent: Claude Code, model claude-opus-5-5)

Row `n` (offset 0) of the triangle lists the prime factors of `3^(3^n) + 2`:
`5`, `29`, `5 * 31 * 127`, ... OEIS comment: "Conjecture: These numbers have no repeating
factors or 3^(3^n) + 2 is squarefree."

## Encoding

* "These numbers have no repeating factors" and "`3^(3^n) + 2` is squarefree" are the same
  claim phrased twice; it is stated once, with Mathlib's `Squarefree`.
* `n` ranges over all of `ℕ`, matching the sequence offset 0 (`3^(3^0) + 2 = 5`).
* The exponent is the tower `3 ^ (3 ^ n)`, written with explicit parentheses.
-/

namespace OMA.S_oeis_a083020

theorem main : ∀ n : ℕ, Squarefree (3 ^ (3 ^ n) + 2) := by
  sorry

end OMA.S_oeis_a083020
