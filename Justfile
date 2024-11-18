#!/usr/bin/env just --justfile

# ===== Base variables =====
PROJECT_NAME := "resume"
DC := "docker-compose"
DC_FILE := "docker-compose.yml"


# ===== Docker automation =====
run:
    @echo "[j] Run the latex Docker container ..."
    {{DC}} run -d --rm latex bash -c "pdflatex -output-directory=/output resume.tex"
    @echo "[j] Done!"

run_linter:
    @echo "[j] Run the chktex(linter) Docker container ..."
    -{{DC}} run --rm chktex
    @echo "[j] Done! Check /output/chktex_output.log for details."

run_format:
    @echo "[j] Run the latex Docker container with formatting ..."
    {{DC}} run -d --rm latex
    @echo "[j] Done!"

up:
	@echo "[j] Run the url api Docker container ..."
	{{DC}} -p {{PROJECT_NAME}} -f {{DC_FILE}} up -d --build
	@echo "[j] Success up!"

down:
	@echo "[j] Stop the url api Docker container ..."
	{{DC}} -p {{PROJECT_NAME}} -f {{DC_FILE}} down
	@echo "[j] Success down!"

rebuild:
	@echo "[m] Rebuild all Docker containers ..."
	{{DC}} -p {{PROJECT_NAME}} -f {{DC_FILE}} up -d --build --force-recreate
	@echo "[m] Rebuild complete!"