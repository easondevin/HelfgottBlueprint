# Helfgott Blueprint

A public Lean 4 / Mathlib skeleton for a Blueprint-driven formalization of
Helfgott's ternary Goldbach theorem.

**Status:** active statement/interface skeleton, not a completed proof.
The top-level theorem and the three main components intentionally contain
`sorry`. The repository exists to make the project structure publicly
inspectable and to provide CI-backed build logs.

## Scope

The intended proof architecture has three components:

1. **Major arcs:** explicit main term and error bound.
2. **Minor arcs:** explicit bounds for log-weighted prime exponential sums.
3. **Finite check:** machine-generated three-prime certificates imported into
   a Lean-checkable interface.

The repository is not a reconstruction of any independent zero-`sorry`
ternary Goldbach repository. Its purpose is to expose the intermediate
explicit estimates in a Mathlib-compatible form.

## Current contents

```text
HelfgottBlueprint/
  Basic.lean          -- three-prime-sum predicate
  CircleMethod.lean   -- finite prime exponential sums
  MajorArcs.lean      -- major-arc estimate interface
  MinorArcs.lean      -- minor-arc estimate interface
  FiniteCheck.lean    -- certificate types and soundness interface
  Assemble.lean       -- proof-assembly placeholder
  Main.lean           -- top-level theorem statement

blueprint/
  src/                -- leanblueprint source
  dependency-map.json -- small machine-readable DAG snapshot

certgen/              -- Rust generator for the small JSONL sample
certificates/         -- checked-in sample certificates for odd 7..31
scripts/              -- certificate verifier and sorry reporter
.github/workflows/    -- Lean and certificate CI
```

## Build

Install `elan`, then run:

```bash
lake update
lake exe cache get
lake build
```

The project pins Lean `v4.36.0` and Mathlib `v4.36.0` through
`lean-toolchain` and `lakefile.toml`. After the first dependency resolution,
commit the generated `lake-manifest.json` to lock all transitive dependency
commits.

To show the remaining placeholders:

```bash
python3 scripts/check_sorries.py
```

`#print axioms ternary_goldbach` in `HelfgottBlueprint/Main.lean` will report
`sorryAx` while the theorem remains unfinished. That is expected at this
stage.

## Certificate sample

The checked-in JSONL file covers only odd integers `7..31`:

```bash
python3 scripts/verify_certificate.py certificates/sample.jsonl
cargo run --quiet --manifest-path certgen/Cargo.toml -- 31
```

This sample validates the certificate schema and CI plumbing. It is **not** a
Helfgott-Platt-scale finite verification artifact, and the current Rust code
is a straightforward prototype rather than a SIMD segmented sieve.

## Blueprint

The source lives in `blueprint/src`. With `leanblueprint` installed, run:

```bash
leanblueprint web
```

or:

```bash
make blueprint
```

Unfinished nodes deliberately do not carry `\leanok`.

## CI

GitHub Actions runs:

- `lake build` via `leanprover/lean-action`;
- the Python certificate verifier;
- regeneration and comparison of the JSONL sample;
- a machine-readable `sorry` report.

A green CI badge means that the public skeleton elaborates and the sample
certificate pipeline is reproducible. It does **not** mean that the theorem is
proved.

## License

Apache-2.0. See `LICENSE`.
