.PHONY: build certificates sorries blueprint

build:
	lake build

certificates:
	python3 scripts/verify_certificate.py certificates/sample.jsonl
	cargo run --quiet --manifest-path certgen/Cargo.toml -- 31 > /tmp/three-prime-certificates.jsonl
	cmp certificates/sample.jsonl /tmp/three-prime-certificates.jsonl

sorries:
	python3 scripts/check_sorries.py

blueprint:
	leanblueprint web
