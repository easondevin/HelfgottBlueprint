import HelfgottBlueprint.Basic
import Mathlib.Analysis.Complex.Exponential

open scoped BigOperators

namespace HelfgottBlueprint

/-- Prime exponential sum over primes below `x`.

This is the finite object whose major/minor-arc decomposition the blueprint
will eventually state with explicit constants. -/
noncomputable def primeExponentialSum (x : ℕ) (α : ℝ) : ℂ :=
  ∑ p ∈ (Finset.range x).filter Nat.Prime,
    Complex.exp (((2 * Real.pi * α * p : ℝ) : ℂ) * Complex.I)

/-- Log-weighted prime exponential sum over primes below `x`. -/
noncomputable def weightedPrimeExponentialSum (x : ℕ) (α : ℝ) : ℂ :=
  ∑ p ∈ (Finset.range x).filter Nat.Prime,
    ((Real.log (p : ℝ) : ℝ) : ℂ) *
      Complex.exp (((2 * Real.pi * α * p : ℝ) : ℂ) * Complex.I)

/-- Center of a rational major-arc box. -/
noncomputable def majorArcCenter (q a : ℕ) : ℝ :=
  (a : ℝ) / (q : ℝ)

end HelfgottBlueprint
