import HelfgottBlueprint.Assemble

namespace HelfgottBlueprint

/-- Helfgott's ternary Goldbach theorem: every odd natural number greater
than `5` is a sum of three primes.

This is the public top-level statement. It intentionally contains `sorry`;
the repository is a Blueprint skeleton, not a claimed completed proof. -/
theorem ternary_goldbach :
    ∀ n : ℕ, Odd n → 5 < n → IsThreePrimeSum n := by
  intro n _h_odd _h_gt_five
  sorry

#print axioms ternary_goldbach

end HelfgottBlueprint
