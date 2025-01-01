#!/usr/bin/env just --justfile

# ===== Base variables =====
DC_COMMAND := "docker-compose -p resume -f docker/docker-compose.yml"
WORK_FOLDERS := "./eng_resume ./ru_resume"


# ===== Base =====
help:
    @echo "Available commands:"
    @echo "  just help          - Show this help message"
    @echo "  just up            - Build the resume builder Docker container"
    @echo "  just down          - Down the resume builder Docker container"
    @echo "  just rebuild       - Rebuild all Docker containers"
    @echo "  just run           - Run the latex Docker container to build the resume"
    @echo "  just run_linter    - Run the chktex linter Docker container"
    @echo "  just run_format    - Run the latex Docker container for formatting"
    @echo "  just remove-bak    - Remove all .bak and .log files from /resume folder"


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


# ===== Clean project =====
remove-bak:
    @echo "[j] Remove all '.bak' and '.log' files from specified folders..."
    for dir in {{WORK_FOLDERS}}; do \
        find "$dir" -type f \( -name '*.bak*' -o -name '*.log' \) -delete; \
    done
    @echo "[j] Done!"