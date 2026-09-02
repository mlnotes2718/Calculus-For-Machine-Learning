project_name := "enter-your-project-name-here"

# Returns 'uv' if the command is installed, otherwise 'conda'
env_type := `[ -n "${CONDA_PREFIX:-}" ] && echo "conda" || echo "uv"`

# Default: List commands
default:
    @just --list

# Setup the environment
setup:
    @if [ "{{env_type}}" = "uv" ]; then \
        echo "🚀 Using {{env_type}} environment..."; \
        uv sync; \
        uv run pre-commit install; \
    else \
        echo "🚀 Using {{env_type}} environment..."; \
        echo "Use conda env create to create a conda environment"; \
        pre-commit install --hook-type pre-commit --hook-type pre-push; \
    fi

## Start of development commands

## Ad hoc Command
# conda env export e.g. `just envexp environment.yml`
envexp *args:
	@if [ "{{env_type}}" = "conda" ]; then \
		echo "🧪 ({{env_type}}) Running Conda Environment export..."; \
		conda env export --from-history --no-build > {{args}}; \
	else \
		echo "🧪 No Export Function for ({{env_type}}) Environment..."; \
	fi

# Pre-commit run before commit
precommit:
    @echo "🔍  ({{env_type}}) Running pre-commit..."
    @if [ "{{env_type}}" = "uv" ]; then \
        uv run pre-commit run --all-files; \
    else \
        pre-commit run --all-files; \
    fi

## List of common command
# Check environment health
health:
    @echo "🩺 ({{env_type}}) Checking environment health..."
    @if [ "{{env_type}}" = "uv" ]; then \
        uv pip check; \
        uv sync; \
    else \
        conda doctor; \
    fi


# Remove build, cache, and coverage artifacts
clean:
    @echo "🧹 Cleaning up project..."
    rm -rf .pytest_cache
    rm -rf .coverage
    rm -rf htmlcov
    rm -rf .mypy_cache
    rm -rf .ruff_cache
    rm -rf .hypothesis
    find . -type d -name "__pycache__" -exec rm -rf {} +
    @echo "✨ Cleaned!"

# Run all checks
run: health clean
