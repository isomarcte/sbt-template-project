#!/bin/bash

set -e

TEMP_DIR="$(mktemp -d)"
readonly TEMP_DIR
export TEMP_DIR

export TARGET_DIR="${TEMP_DIR:?}/sbt-project"

# Register cleanup handler
trap 'rm -rf ${TEMP_DIR}' ERR

function cleanup_on_success {
    if [ -n "${NOT_CI}" ]
    then
        read -r -p "Delete test directory ${TEMP_DIR:?}? (Yes): " SHOULD_DELETE
    else
        SHOULD_DELETE='yes'
    fi

    export SHOULD_DELETE

    if [ -n "${SHOULD_DELETE}" ]
    then
        SHOULD_DELETE="$(echo "${SHOULD_DELETE:?}" | tr '[:upper:]' '[:lower:]' | tr -d '[:blank:]')"
    fi

    readonly SHOULD_DELETE

    if [ "${SHOULD_DELETE}" = 'no' ]
    then
        echo "Leaving directory ${TEMP_DIR:?} alone because SHOULD_DELETE was ${SHOULD_DELETE:?}"
        return 0
    else
        rm -rf "${TEMP_DIR:?}"
    fi
}

function main {
    echo "Test project in ${TARGET_DIR}"
    ./setup.sh
    cleanup_on_success
}

main "$@"
