import HelfgottBlueprint.Basic

namespace HelfgottBlueprint

/-- A certificate exhibiting `n` as a sum of three primes. -/
structure ThreePrimeCertificate (n : ℕ) where
  p : ℕ
  q : ℕ
  r : ℕ
  hp : p.Prime
  hq : q.Prime
  hr : r.Prime
  sum : p + q + r = n

/-- A certificate is sound by construction. -/
theorem certificate_sound (n : ℕ) (certificate : ThreePrimeCertificate n) :
    IsThreePrimeSum n := by
  exact ⟨certificate.p, certificate.q, certificate.r,
    certificate.hp, certificate.hq, certificate.hr, certificate.sum⟩

/-- Certificates covering every odd number in a finite interval. -/
structure FiniteIntervalCertificate where
  lower : ℕ
  upper : ℕ
  certificate : ∀ n : ℕ, lower ≤ n → n ≤ upper → Odd n →
    ThreePrimeCertificate n

/-- Soundness theorem for interval certificates exported by the sieve. -/
theorem finite_interval_sound (certificate : FiniteIntervalCertificate) :
    ∀ n : ℕ, certificate.lower ≤ n → n ≤ certificate.upper → Odd n →
      IsThreePrimeSum n := by
  intro n h_lower h_upper h_odd
  exact certificate_sound n
    (certificate.certificate n h_lower h_upper h_odd)

/-- Placeholder for the finite certificate interval needed by the final proof. -/
theorem helfgott_finite_interval_certificate : Nonempty FiniteIntervalCertificate := by
  sorry

/-- Minimal worked example: `7 = 2 + 2 + 3`. -/
def certificateSeven : ThreePrimeCertificate 7 where
  p := 2
  q := 2
  r := 3
  hp := by decide
  hq := by decide
  hr := by decide
  sum := by decide

example : IsThreePrimeSum 7 :=
  certificate_sound 7 certificateSeven

end HelfgottBlueprint
