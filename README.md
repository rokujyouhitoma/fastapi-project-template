# FastAPI Project Template

## What is setupped?

 - Poetry
 - isort
 - Black
 - Flake8
 - Radon
 - Xenon
 - Mypy
 - pytest, pytest-cov, pytest-xdist

----

## Requirements

 - Python 3.9
 - poetry

## Installation

on macOS

```
brew install poetry
```

```
make setup
```

## Run

```
make
```

## Run the fast api application

```
PYTHONPATH=src uvicorn sample.__main__:app --reload
```
