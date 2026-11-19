#!/usr/bin/env python3
"""Validate the small three-prime JSONL certificate sample."""

from __future__ import annotations

import json
import math
import sys
from pathlib import Path


def is_prime(n: int) -> bool:
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for d in range(3, math.isqrt(n) + 1, 2):
        if n % d == 0:
            return False
    return True


def main() -> int:
    path = Path(sys.argv[1] if len(sys.argv) > 1 else "certificates/sample.jsonl")
    seen: dict[int, tuple[int, int, int]] = {}

    with path.open("r", encoding="utf-8") as handle:
        for line_number, line in enumerate(handle, start=1):
            if not line.strip():
                continue
            record = json.loads(line)
            n = int(record["n"])
            p = int(record["p"])
            q = int(record["q"])
            r = int(record["r"])

            if n in seen:
                raise ValueError(f"line {line_number}: duplicate n={n}")
            if n < 7 or n % 2 == 0:
                raise ValueError(f"line {line_number}: n={n} is not an odd integer >= 7")
            if not all(is_prime(x) for x in (p, q, r)):
                raise ValueError(f"line {line_number}: non-prime entry in {p}, {q}, {r}")
            if p + q + r != n:
                raise ValueError(f"line {line_number}: {p}+{q}+{r} != {n}")

            seen[n] = (p, q, r)

    expected = set(range(7, 32, 2))
    missing = sorted(expected - set(seen))
    extra = sorted(set(seen) - expected)
    if missing or extra:
        raise ValueError(f"coverage mismatch: missing={missing}, extra={extra}")

    print(f"validated {len(seen)} certificates from {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
