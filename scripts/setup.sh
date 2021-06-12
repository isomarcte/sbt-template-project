#!/bin/bash

set -e

function sanity_check {
    if [ -z "${TARGET_DIR}" ]
    then
        if [ -n "${1}" ]
        then
            declare -r TARGET_DIR="${1:?}"
        else
            # shellcheck disable=SC2016
            echo 'TARGET_DIR is not set and $1 is empty, but one must be set to run this script.' 1>&2
            exit 1
        fi
    fi

    export TARGET_DIR

    if [ -e "${TARGET_DIR}" ]
    then
        echo "${TARGET_DIR} already exists in the filesystem. You must provide a name for a directory which does not currently exist." 1>&2
        exit 2
    fi
}

function main {
    sanity_check "$@"
    ./setup-git.sh "$@"
    ./setup-template.sh "$@"
}

main "$@"
