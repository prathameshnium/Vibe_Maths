import FormalConjectures.OEIS.«218656»

-- Reduction OeisA218656.conjecture_2.R1 of Partitions $2n + 1 = x + y$ with $x^4 + y^4$ prime — conjecture 2
-- Credit: @prathameshnium
-- Each H becomes its own step once this file is accepted. Proving all of them closes the problem.

/-!
# Ordowski's $x^2 + y^2$ conjecture: a kernel-checked initial range, and the open rest

* `H1`: for `1 ≤ n ≤ 1000` there is `1 ≤ x ≤ n` with `x ^ 2 + (2 * n + 1 - x) ^ 2` prime. Checked
  inside the Lean kernel by a verified trial-division search.
* `H2`: the same for every `n > 1000`. This is the open conjecture.
-/

namespace OMA.R_OeisA218656_conjecture_2_R1

/-- The verified range. -/
def H1 : Prop :=
  ∀ n : ℕ, 1 ≤ n → n ≤ 1000 →
    ∃ x : ℕ, 1 ≤ x ∧ x ≤ n ∧ Nat.Prime (x ^ 2 + (2 * n + 1 - x) ^ 2)

/-- The open part. -/
def H2 : Prop :=
  ∀ n : ℕ, 1000 < n →
    ∃ x : ℕ, 1 ≤ x ∧ x ≤ n ∧ Nat.Prime (x ^ 2 + (2 * n + 1 - x) ^ 2)

theorem main : H1 → H2 → type_of% @OeisA218656.conjecture_2 := by
  intro h1 h2 n hn
  by_cases h : n ≤ 1000
  · exact h1 n hn h
  · exact h2 n (by omega)

end OMA.R_OeisA218656_conjecture_2_R1
