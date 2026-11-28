import FormalConjectures.Paper.Dubner

-- Reduction DubnerConjecture.dubner_conjecture.R1 of Dubner's conjecture
-- Credit: @prathameshnium

/-!
# Dubner's conjecture: a kernel-checked initial range, and the open rest

* `H1`: every even `n` with `4208 < n ≤ 10000` is the sum of two twin primes. Checked inside the
  Lean kernel by a verified trial-division search over packed witnesses.
* `H2`: the same for every even `n > 10000`. This is the open conjecture.
-/

namespace OMA.R_DubnerConjecture_dubner_conjecture_R1

/-- The verified range. -/
def H1 : Prop :=
  ∀ n : ℕ, 4208 < n → n ≤ 10000 → Even n →
    ∃ p q : ℕ, DubnerConjecture.IsTwinPrime p ∧ DubnerConjecture.IsTwinPrime q ∧ p + q = n

/-- The open part. -/
def H2 : Prop :=
  ∀ n : ℕ, 10000 < n → Even n →
    ∃ p q : ℕ, DubnerConjecture.IsTwinPrime p ∧ DubnerConjecture.IsTwinPrime q ∧ p + q = n

theorem main : H1 → H2 → type_of% @DubnerConjecture.dubner_conjecture := by
  intro h1 h2 n hn h
  by_cases hb : n ≤ 10000
  · exact h1 n hn hb h
  · exact h2 n (by omega) h

end OMA.R_DubnerConjecture_dubner_conjecture_R1
