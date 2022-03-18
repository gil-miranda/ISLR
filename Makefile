PYTHON_INTERPRETER=python3

# Compile Python Dependencies files

install-pip-tools:
	$(PYTHON_INTERPRETER) -m pip install pip-tools

## Install Python Dependencies & Install pre-commit hooks

pip-compile: install-pip-tools
	pip-compile --no-emit-index-url requirements.in

## Synchronize the Python Dependencies & Virtual Env
sync-env: pip-compile
	pip-sync requirements.txt

## Install Python Dependencies & Install pre-commit hooks
requirements: pip-compile
	$(PYTHON_INTERPRETER) -m pip install -r requirements.txt --use-deprecated=legacy-resolver
	pre-commit install --hook-type commit-msg

## Delete all compiled Python files
clean:
	@find . -type f -name "*.py[co]" -delete
	@find . -type d -name "__pycache__" -delete
	@find . -type d -name ".pytest_cache" -exec rm -r "{}" +