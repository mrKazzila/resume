#!/usr/bin/env just --justfile

# ===== Base variables =====
PROJECT_NAME := "resume"
DC := "docker-compose"
DC_FILE := "docker-compose.yml"

# ===== Docker automation =====
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