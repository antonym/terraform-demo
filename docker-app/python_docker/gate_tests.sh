#!/usr/bin/env bash
set +x
# This script assumes its run in a directory with ./app and ./tests local to it

DEFAULT_DIR="/opt/pysetup"
LOCAL_DIR=${1:-$DEFAULT_DIR}

function run_poetry_check() {
    cd ${LOCAL_DIR} && poetry check && cd -
}

function run_flake8() {
    flake8 --max-line-length=88 --count --statistics ./app ./tests
}

function run_black() {
    black --config ${LOCAL_DIR}/pyproject.toml --check ./app ./tests
}

function run_isort() {
    isort --settings-path ${LOCAL_DIR}/pyproject.toml --check-only ./app ./tests
}

function run_bandit() {
    bandit -r ./app ./tests
}

function run_safety() {
    safety check --cache --full-report
}

function run_coverage() {
    coverage run -m --branch --omit='*/tests/*' --source ./app pytest -vv ./tests && \
    coverage report -m --skip-covered --skip-empty --fail-under=75
}

commands=( \
    run_poetry_check \
    run_flake8 \ 
    run_black \
    run_isort \
    run_bandit \
    run_safety \
    run_coverage \
)

for c in ${commands[@]}; do
    ${c}
    (( $? == 0 )) || { echo "FAILED: ${c}"; exit 15; }
done