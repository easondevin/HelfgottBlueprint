import Mathlib.Data.Nat.Prime.Basic

namespace HelfgottBlueprint

/-- `n` is a sum of three primes. -/
def IsThreePrimeSum (n : ℕ) : Prop :=
  ∃ p q r : ℕ, p.Prime ∧ q.Prime ∧ r.Prime ∧ p + q + r = n

end HelfgottBlueprint
