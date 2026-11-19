import HelfgottBlueprint.CircleMethod

namespace HelfgottBlueprint

/-- Interface for an explicit major-arc main term and error bound.

The fields are deliberately data-carrying so that the Blueprint can replace
this interface by the precise Helfgott statements one lemma at a time. -/
structure MajorArcEstimate where
  mainTerm : ℕ → ℝ
  errorBound : ℕ → ℝ
  mainTerm_nonneg : ∀ N : ℕ, 0 ≤ mainTerm N
  errorBound_nonneg : ∀ N : ℕ, 0 ≤ errorBound N

/-- Basic sanity consequence of a major-arc estimate. -/
theorem major_arc_main_term_nonneg (estimate : MajorArcEstimate) (N : ℕ) :
    0 ≤ estimate.mainTerm N :=
  estimate.mainTerm_nonneg N

/-- Placeholder for the explicit major-arc asymptotic used by Helfgott. -/
theorem helfgott_major_arc_estimate : Nonempty MajorArcEstimate := by
  sorry

end HelfgottBlueprint
