#!/bin/sh

set -eu

project_dir="${PEEKY_PROJECT:-$PWD}"
target="${1:-.}"

if [ ! -d "$project_dir" ]; then
  printf 'Cannot run Python tests: project directory does not exist: %s\n' "$project_dir" >&2
  exit 1
fi

cd -- "$project_dir"

if ! command -v python3 >/dev/null 2>&1; then
  printf 'Cannot run Python tests: python3 is not installed or is not on PATH.\n' >&2
  exit 1
fi

if ! command -v pytest >/dev/null 2>&1; then
  printf 'Cannot run Python tests: pytest is not installed or is not on PATH. Install it with "pipx install pytest" or "python3 -m pip install pytest".\n' >&2
  exit 1
fi

if ! pytest "$target"; then
  printf 'Python tests failed for target: %s\n' "$target" >&2
  exit 1
fi

printf 'Python tests passed for target: %s\n' "$target"
