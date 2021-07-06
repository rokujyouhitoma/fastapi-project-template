PACKAGE=sample
PYTHON=python3.8
POETRY=poetry
SRC=src
TESTS=tests

all: clean format static_analysis test build

.PHONY: help
help: ## help command
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## clean
	rm -rf dist/

.PHONY: setup
setup: activate install ## setup venv, activate and install python libraries

.PHONY: activate
activate: ## Activate venv
	poetry env use ${PYTHON}
	. .venv/bin/activate

.PHONY: install
install: ## Install python libraries
	poetry install

.PHONY: format
format: isort black flake8 ## format

.PHONY: static_analysis
static_analysis: radon-cc radon-raw radon-mi radon-hal xenon mypy ## static analysis

.PHONY: test
test: pytest ## pytest

.PHONY: build
build: ## run python code
	${POETRY} build

.PHONY: isort
isort: ## isort
	isort ${SRC}

.PHONY: black
black: ## black
	find ${SRC} -name "*.py" | xargs black

.PHONY: flake8
flake8: ## flake8
	flake8 --max-line-length=120 ${SRC}

.PHONY: radon-cc
radon-cc: ## radon compute Cyclomatic Complexity (CC)
	radon cc ${SRC} -s -a -na

.PHONY: radon-raw
radon-raw: ## radon compute raw metrics
	radon raw ${SRC}

.PHONY: radon-mi
radon-mi: ## radon compute the Maintainability Index
	radon mi ${SRC} -s -na

.PHONY: radon-hal
radon-hal: ## radon compute their Halstead metrics
	radon hal ${SRC}

.PHONY: xenon
xenon: ## xenon
	xenon --max-absolute A --max-modules A --max-average A ${SRC}

.PHONY: mypy
mypy: ## mypy
	mypy --strict ${SRC}

.PHONY: pytest
pytest: ## pytest
	PYTHONPATH=${SRC} pytest --cov=${SRC} --cov-fail-under=70 -v ${TESTS} --cov-report=term-missing -n 2

