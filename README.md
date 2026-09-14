# Python Toolkit for Peeky Code

Python Toolkit adds Black formatting, Ruff diagnostics, and safe project
actions to Peeky Code.

## Capabilities

- Formats `.py` and `.pyi` buffers with Black.
- Lints `.py` and `.pyi` files with Ruff and shows line and column
  diagnostics in Peeky Code.
- Runs all tests, a test file, or a specific test with `run_python_tests`.
- Checks project syntax and Ruff rules with `check_python_project`.

The actions only read or execute code in the selected project. They do not
modify project files, evaluate generated shell commands, or perform
irreversible operations.

## Requirements

Install Python 3 and the tools for the capabilities you want to use. The
commands must be available on the `PATH` seen by Peeky Code.

With [pipx](https://pipx.pypa.io/):

```sh
brew install python pipx
pipx ensurepath
pipx install black
pipx install ruff
pipx install pytest
```

Alternatively, install the tools with Python:

```sh
python3 -m pip install black ruff pytest
```

Restart Peeky Code after installing tools so it receives the updated `PATH`.
Black is only needed for formatting, Ruff for linting and project checks, and
pytest for the test action.

## Install

In Peeky Code, open **Extensions**, choose **Install from git URL...**, and
enter:

```text
https://github.com/viraone/peeky-extension-python.git
```

You can also clone or copy this repository to:

```text
~/Library/Application Support/MyClicky/Extensions/python-toolkit
```

Reload extensions or restart Peeky Code after installing.

## Use

Open a Python file and use **Format** to run Black or the lint control to run
Ruff. In the Extensions tab, use the action play button to:

- Run `run_python_tests` with no target for the whole project.
- Pass an optional target such as `tests/test_api.py` or
  `tests/test_api.py::test_name` to limit pytest.
- Run `check_python_project` to compile Python sources and lint the project.

The actions run from `PEEKY_PROJECT` when Peeky provides it, otherwise from
their current working directory. Their final output line summarizes success
for Peeky's result toast.

## Environment

Peeky supplies extension context through environment variables:

| Variable | Purpose |
|---|---|
| `PEEKY_PROJECT` | Selected project directory and action working directory |
| `PEEKY_FILE` | File currently open in Peeky Code |
| `PEEKY_EXTENSION_ID` | Extension identifier |
| `PEEKY_EXTENSION_DIR` | Installed extension directory |
| `PEEKY_VERB` | Action verb being run |
| `PEEKY_PARAM_TARGET` | Optional target for `run_python_tests` |

Action parameters are also passed positionally in manifest order and as a
JSON object on standard input. The scripts use the positional target and do
not evaluate parameter contents.

## License

[MIT](LICENSE)
