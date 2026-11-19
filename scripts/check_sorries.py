#!/usr/bin/env python3
"""Report remaining Lean `sorry` placeholders without failing the build."""

from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PATTERN = re.compile(r"\bsorry\b")
BLOCK_COMMENT = re.compile(r"/-.*?-/", re.DOTALL)


def lean_code_only(text: str) -> str:
    """Remove Lean block comments/docstrings and line comments."""
    without_blocks = BLOCK_COMMENT.sub("", text)
    return "\n".join(line.split("--", 1)[0] for line in without_blocks.splitlines())


report: dict[str, int] = {}
for path in sorted(ROOT.rglob("*.lean")):
    if ".lake" in path.parts:
        continue
    count = len(PATTERN.findall(lean_code_only(path.read_text(encoding="utf-8"))))
    if count:
        report[str(path.relative_to(ROOT))] = count

print(json.dumps({"sorry_count": sum(report.values()), "files": report}, indent=2))
