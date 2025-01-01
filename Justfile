#!/usr/bin/env just --justfile

# ===== Base variables =====
DC_COMMAND := "docker-compose -p resume -f docker/docker-compose.yml"


# ===== Base =====
help:
    @echo "Available commands:"
    @echo "  run          - Run the latex Docker container to build the resume"
    @echo "  run_linter   - Run the chktex linter Docker container"
    @echo "  run_format   - Run the latex Docker container for formatting"
    @echo "  up           - Build the resume builder Docker container"
    @echo "  down         - Down the resume builder Docker container"
    @echo "  rebuild      - Rebuild all Docker containers"
    @echo "  help         - Show this help message"


# ===== Docker automation =====
run:
    @echo "[j] Run the latex Docker container ..."
    @{{DC_COMMAND}} run -d --rm latex bash -c "pdflatex -output-directory=/output resume.tex"
    @echo "[j] Done!"

run_linter:
    @echo "[j] Run the chktex(linter) Docker container ..."
    @{{DC_COMMAND}} run -d --rm chktex
    @echo "[j] Done! Check /output/chktex_output.log for details."

run_format:
    @echo "[j] Run the latex Docker container with formatting ..."
    @{{DC_COMMAND}} run -d --rm latex
    @echo "[j] Done!"

up:
	@echo "[j] Build the resume builder Docker container ..."
	{{DC_COMMAND}} up -d --build
	@echo "[j] Success up!"

down:
	@echo "[j] Down the resume builder Docker container ..."
	{{DC_COMMAND}} down
	@echo "[j] Success down!"

rebuild:
	@echo "[m] Rebuild all Docker containers ..."
	{{DC_COMMAND}} up -d --build --force-recreate
	@echo "[m] Rebuild complete!"