#!/bin/sh

set -eu

project_dir="${PEEKY_PROJECT:-$PWD}"

if [ ! -d "$project_dir" ]; then
  printf 'Cannot check Python project: project directory does not exist: %s\n' "$project_dir" >&2
  exit 1
fi

cd -- "$project_dir"

if ! command -v python3 >/dev/null 2>&1; then
  printf 'Cannot check Python project: python3 is not installed or is not on PATH.\n' >&2
  exit 1
fi

if ! command -v ruff >/dev/null 2>&1; then
  printf 'Cannot check Python project: ruff is not installed or is not on PATH. Install it with "pipx install ruff" or "python3 -m pip install ruff".\n' >&2
  exit 1
fi

if ! python3 - <<'PY'
import os
import sys
import tokenize

excluded = {".git", ".hg", ".mypy_cache", ".pytest_cache", ".ruff_cache", ".tox", ".venv", "venv", "__pycache__"}
failures = 0

for root, directories, files in os.walk("."):
    directories[:] = [name for name in directories if name not in excluded]
    for name in files:
        if not name.endswith((".py", ".pyi")):
            continue
        path = os.path.join(root, name)
        try:
            with tokenize.open(path) as source_file:
                compile(source_file.read(), path, "exec")
        except (OSError, SyntaxError) as error:
            print(f"{path}: {error}", file=sys.stderr)
            failures += 1

sys.exit(1 if failures else 0)
PY
then
  printf 'Python syntax check failed. Review the compiler errors above.\n' >&2
  exit 1
fi

if ! ruff check --output-format concise .; then
  printf 'Ruff found issues in the Python project. Review the diagnostics above.\n' >&2
  exit 1
fi

printf 'Python project check passed: syntax is valid and Ruff found no issues.\n'
