import OMAReductions.R_OeisA232194_conjecture_4_R1
import Mathlib

-- Step OeisA232194.conjecture_4.R1.H1: hypothesis H1 of reduction OeisA232194.conjecture_4.R1
-- Credit: @prathameshnium. Finite check for 1 < n ≤ 1000, n ≠ 8: a verified trial-division
-- search for the least x with n * x ^ 2 + (n - x) prime, evaluated by the Lean kernel (decide +kernel).

/-! Step OeisA232194.conjecture_4.R1.H1. -/

namespace OMA.A232194Check

/-- `noDiv p f d = true` means: no `m` with `d ≤ m`, `m * m ≤ p` divides `p` (checked with fuel `f`). -/
def noDiv (p : ℕ) : ℕ → ℕ → Bool
  | 0, _ => false
  | f + 1, d => if Nat.blt p (d * d) then true else if Nat.beq (p % d) 0 then false else noDiv p f (d + 1)

/-- Trial-division primality test. -/
def isPrimeB (p : ℕ) : Bool := Nat.ble 2 p && noDiv p p 2

/-- Search `x = x0, x0+1, ...` (fuel `f`) for a prime `n * x ^ 2 + (n - x)`. -/
def findX (n : ℕ) : ℕ → ℕ → Bool
  | 0, _ => false
  | f + 1, x => if isPrimeB (n * x ^ 2 + (n - x)) then true else findX n f (x + 1)

/-- Check every `n ≤ k` with `2 ≤ n`, `n ≠ 8`. -/
def checkAll : ℕ → Bool
  | 0 => true
  | k + 1 => (Nat.beq (k + 1) 8 || Nat.blt (k + 1) 2 || findX (k + 1) k 1) && checkAll k

theorem noDiv_sound (p : ℕ) : ∀ f d, noDiv p f d = true → ∀ m, d ≤ m → m * m ≤ p → ¬ m ∣ p := by
  intro f
  induction f with
  | zero => intro d h; simp [noDiv] at h
  | succ f ih =>
    intro d h m hdm hmm hdiv
    simp only [noDiv] at h
    by_cases h1 : Nat.blt p (d * d) = true
    · rw [Nat.blt_eq] at h1
      have : d * d ≤ m * m := Nat.mul_le_mul hdm hdm
      omega
    · rw [if_neg h1] at h
      by_cases h2 : Nat.beq (p % d) 0 = true
      · rw [if_pos h2] at h; exact Bool.false_ne_true h
      · rw [if_neg h2] at h
        rcases Nat.eq_or_lt_of_le hdm with h3 | h3
        · subst h3
          exact h2 (by rw [Nat.beq_eq]; exact Nat.mod_eq_zero_of_dvd hdiv)
        · exact ih (d + 1) h m h3 hmm hdiv

theorem isPrimeB_sound (p : ℕ) (h : isPrimeB p = true) : p.Prime := by
  simp only [isPrimeB, Bool.and_eq_true, Nat.ble_eq] at h
  obtain ⟨h2, h⟩ := h
  have hnd := noDiv_sound p p 2 h
  by_contra hp
  have hp1 : p ≠ 1 := by omega
  have hmp := Nat.minFac_prime hp1
  have hsq := Nat.minFac_sq_le_self (by omega) hp
  exact hnd p.minFac hmp.two_le (by rw [← pow_two]; exact hsq) (Nat.minFac_dvd p)

theorem findX_sound (n : ℕ) : ∀ f x, findX n f x = true →
    ∃ x', x ≤ x' ∧ x' < x + f ∧ (n * x' ^ 2 + (n - x')).Prime := by
  intro f
  induction f with
  | zero => intro x h; simp [findX] at h
  | succ f ih =>
    intro x h
    simp only [findX] at h
    by_cases h1 : isPrimeB (n * x ^ 2 + (n - x)) = true
    · exact ⟨x, le_rfl, by omega, isPrimeB_sound _ h1⟩
    · rw [if_neg h1] at h
      obtain ⟨x', h3, h4, h5⟩ := ih (x + 1) h
      exact ⟨x', by omega, by omega, h5⟩

theorem checkAll_sound : ∀ k, checkAll k = true → ∀ n, n ≤ k → 2 ≤ n → n ≠ 8 →
    findX n (n - 1) 1 = true := by
  intro k
  induction k with
  | zero => intro _ n hn h2; omega
  | succ k ih =>
    intro h n hn h2 h8
    simp only [checkAll, Bool.and_eq_true, Bool.or_eq_true] at h
    obtain ⟨h1, h⟩ := h
    rcases Nat.eq_or_lt_of_le hn with h3 | h3
    · subst h3
      rcases h1 with (h1 | h1) | h1
      · rw [Nat.beq_eq] at h1; exact absurd h1 h8
      · rw [Nat.blt_eq] at h1; omega
      · simpa using h1
    · exact ih h n (by omega) h2 h8

theorem checkAll_B : checkAll 1000 = true := by decide +kernel

end OMA.A232194Check

open OMA.A232194Check in
theorem OMA.solution : OMA.R_OeisA232194_conjecture_4_R1.H1 := by
  intro n hn hB h8
  obtain ⟨x, h1, h2, h3⟩ := findX_sound n (n - 1) 1 (checkAll_sound 1000 checkAll_B n hB hn h8)
  exact ⟨x, n - x, h1, by omega, by omega, h3⟩

