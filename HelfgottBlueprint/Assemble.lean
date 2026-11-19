import HelfgottBlueprint.MajorArcs
import HelfgottBlueprint.MinorArcs
import HelfgottBlueprint.FiniteCheck

namespace HelfgottBlueprint

/-- The three proof components that must eventually be assembled. -/
structure HelfgottComponents where
  major : MajorArcEstimate
  minor : MinorArcEstimate
  finite : FiniteIntervalCertificate

/-- Assembly placeholder.

The final proof will combine the major-arc main term, the minor-arc explicit
bound, and the finite interval certificate. It remains a `sorry` on purpose. -/
theorem ternary_goldbach_from_components (_components : HelfgottComponents) :
    ∀ n : ℕ, Odd n → 5 < n → IsThreePrimeSum n := by
  intro n _h_odd _h_gt_five
  sorry

end HelfgottBlueprint
